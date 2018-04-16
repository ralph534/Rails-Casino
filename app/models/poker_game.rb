class PokerGame < ApplicationRecord
  has_many :betting_rounds, class_name: 'BettingRound', dependent: :destroy
  has_many :deck_cards, class_name: 'DeckCard', dependent: :destroy
  has_many :poker_hands, class_name: 'PokerHand', dependent: :destroy
  has_one :deck, class_name: 'Deck', dependent: :destroy
  after_create :start_betting_rounds
  after_create :starting_deck
  after_create :create_hands
  after_create :flop

  def flop
    flop = self.deck_cards.sample(5)
    flop.each do |dc|
      dc.update!(drawn: true)
    end
    self.update!(flop_1: flop[0].card_id, flop_2: flop[1].card_id, flop_3: flop[2].card_id,
                 flop_4: flop[3].card_id, flop_5: flop[4].card_id)
  end

  def players
    players = [self.player1, self.player2, self.player3, self.player4,
              self.player5, self.player6, self.player7, self.player8]
    players = players.select { |p| !p.nil? }
  end

  def first_player_turn
    User.find(self.players[0]).update!(turn: true)
  end

  def current_betting_round
    self.betting_rounds.last
  end

  def next_turn
    self.update!(current_turn: turn_idx)
  end

  def turn_idx
    idx = self.current_turn
    if idx == players.size - 1
      idx = 0
    else 
      idx += 1
    end
    idx
  end

  def poker_moves
    PokerMove.where(poker_game_id: self.id)
  end

  def next_betting_round
    next_round = self.current_betting_round.round_number + 1
    BettingRound.create(round_number: next_round, poker_game_id: self.id)
  end

  private
    def create_hands
      players.each do |player|
        cards = available_cards.sample(2)
        PokerHand.create(user_id: player, poker_game_id: self.id, card1_id: cards[0].card_id, card2_id: cards[1].card_id)
        cards.each do |card|
          self.deck_cards.find(card.id).update!(drawn: true)
        end
      end
    end 

    def available_cards
      self.deck_cards.select { |c| !c.drawn }
    end

    def start_betting_rounds
      round = BettingRound.create(round_number: 1, poker_game_id: self.id)
    end

    def starting_deck
      Deck.create(poker_game_id: self.id)
    end
end