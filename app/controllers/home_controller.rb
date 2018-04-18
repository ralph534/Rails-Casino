class HomeController < ApplicationController
  respond_to :html, :js

  def index
    @incoming = FriendRequest.where(requested_id: current_user)
    game = Game.new
    game.save
    blackjackgame = BlackjackGame.new(user_id: current_user.id, game_id: game.id)
    blackjackgame.save
    current_user.update!(game_id: blackjackgame.id)
    BlackjackHand.create(blackjack_game_id: blackjackgame.id, card1: random_card, card2: random_card, holder: 'player')
    BlackjackHand.create(blackjack_game_id: blackjackgame.id, card1: random_card, card2: random_card, holder: 'dealer')
    @human_hand = blackjackgame.hands.for_player.initial_deal
    @dealer_hand = blackjackgame.hands.for_dealer.initial_deal
  end

  def hit
    game = current_user.blackjack_game
    game.player_hits
    @card = game.hands.for_player.hits.pop
    if game.player_busts? || game.hands.for_player.value == 21
      stay
    end
  end 

  def stay
    game = current_user.blackjack_game
    game.dealer_turn
    dealer_cards = game.hands.for_dealer.cards
    @cards = dealer_cards[1..-1]
    @winner = game.find_winner
    if @winner == "BLACKJACK! You win!" || @winner == "You win!"
      ActionCable.server.broadcast "notifications_channel_#{current_user.id}",
                                    jackpot: true
    end
  end

  def wager
    game = current_user.blackjack_game
    current_wager = game.wager
    sum = current_wager + params[:wager].to_i
    game.update!(wager: sum)
    @current_wager = game.wager
  end

  private

  def random_card
    idx = rand(52) + 1
    Card.find(idx)
  end

  # def current_balance
  #   current_user.balance
  # end
end 