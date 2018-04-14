class BlackjackGame < ApplicationRecord
  # before_create :deal_hands
  belongs_to :game
  belongs_to :user
  has_many :hands, class_name: 'BlackjackHand'

  def find_winner
    if self.hands.for_player.value == self.hands.for_dealer.value
      self.update!(winner: 'draw')
      "It's a draw!"
    elsif dealer_busts? && player_busts?
      self.update!(winner: 'draw')
      "You both bust! It's a draw!"
    elsif dealer_busts? && !player_busts?
      self.update!(winner: 'player')
      (self.hands.for_player.value == 21) ? "BLACKJACK! You win!" : "Dealer busts! You win!"
    elsif player_busts? && !dealer_busts?
      self.update!(winner: 'dealer')
      (self.hands.for_dealer.value == 21) ? "Dealer wins with BLACKJACK!" : "You bust! Dealer wins!"
    elsif self.hands.for_player.value > self.hands.for_dealer.value
      self.update!(winner: 'player')
      "You win!"
    else
      self.update!(winner: 'dealer')
      "Dealer wins!"
    end
  end

  def player_hand
    self.hands.for_player.initial_deal + self.hands.for_player.hits 
  end

  def dealer_hand
    self.hands.for_dealer.initial_deal + self.hands.for_dealer.hits
  end

  def player_hits
    hand_id = self.hands.for_player.id
    new_card = random_card
    BlackjackMove.create(blackjack_hand_id: hand_id, user_id: self.user_id, stay: false, card: new_card)
    updating_hand = BlackjackHand.find(hand_id)
    case updating_hand.card_count
    when 2
      updating_hand.update!(card3: new_card)
    when 3
      updating_hand.update!(card4: new_card)
    when 4
      updating_hand.update!(card5: new_card)
    when 5
      updating_hand.update!(card6: new_card)
    when 6
      updating_hand.update!(card7: new_card) 
    end
  end

  def dealer_turn
    dealer_hand = self.hands.for_dealer
    until dealer_hand.value >= 17 do
      new_card = random_card
      case dealer_hand.cards.count
      when 2
        dealer_hand.update!(card3: new_card)
      when 3
        dealer_hand.update!(card4: new_card)
      when 4
        dealer_hand.update!(card5: new_card)
      when 5
        dealer_hand.update!(card6: new_card)
      when 6
        dealer_hand.update!(card7: new_card) 
      end
    end
  end

  def player_busts?
    self.hands.for_player.value > 21
  end

  def dealer_busts?
    self.hands.for_dealer.value > 21
  end

  private
    def random_card
      idx = rand(52) + 1
      Card.find(idx)
    end
end
