class PokerController < ApplicationController
  respond_to :html, :js
  # before_action :get_messages

  def create
    invitation = Invitation.find(params[:invitation])
    players = [invitation.sender_id, invitation.recipient_id]
    poker_room = PokerRoom.new(player1: players[0], player2: players[1],
                 player3: players[2], player4: players[3], player5: players[4],
                 player6: players[5], player7: players[6], player8: players[7])
    if poker_room.save 
      room_id = poker_room.id
      game = PokerGame.new(pot: 0, poker_room_id: room_id, player1: players[0], player2: players[1], player3: players[2],
                         player4: players[3], player4: players[4], player5: players[5],
                         player6: players[6], player7: players[7], player8: players[8])
      if game.save 
        poker_room.update!(current_poker_game_id: game.id)
      end
      players.each do |player|
        User.find(player).update_attribute(:current_room, room_id)
      end
    end
    ActionCable.server.broadcast "invitations_channel_#{invitation.sender_id}",
                                  url: poker_path
    redirect_to poker_path
  end

  def show
    room = current_user.current_room
    # current_user.update!(current_room: 
    game = PokerGame.find_by(poker_room_id: room)
    current_user.update!(poker_game: game)
    # @flop = [game.flop_1, game.flop_2, game.flop_3,
    #          game.flop_4, game.flop_5]
    # @lobby = game.players
    game.first_player_turn
    user_hand = game.poker_hands.find_by(user_id: current_user.id)
    @cards = [Card.find(user_hand.card1_id), Card.find(user_hand.card2_id)]
    @current_user_turn = current_user.turn
  end

  def bet
    room = current_user.current_room
    game = PokerGame.find_by(poker_room_id: room)
    round = game.current_betting_round
    if params[:bet]
      room = current_user.current_room
      bet = params[:bet].to_i
      sum = game.pot + bet
      game.update!(pot: sum)
      game.players.each do |player|
        ActionCable.server.broadcast "room_channel_#{player}",
                                      pot: game.pot
      end
      PokerMove.create(user_id: current_user.id, poker_game_id: game.id, betting_round: round.id,
        move: 'raise', raise_amt: bet)
    else 
      PokerMove.create(user_id: current_user.id, poker_game_id: game.id, betting_round: round.id,
        move: 'end betting', raise_amt: 0)
      better_idx = game.current_turn
      game.next_turn
      ActionCable.server.broadcast "room_channel_#{game.players[game.current_turn]}",
                                    turn: true
      ActionCable.server.broadcast "room_channel_#{game.players[better_idx]}",
                                    not_turn: true                                         
    end
  end

  def call
    room = current_user.current_room
    game = PokerGame.find_by(poker_room_id: room)
    round = game.current_betting_round
    PokerMove.create(user_id: current_user.id, poker_game_id: game.id, betting_round: round.id,
                     move: 'call', raise_amt: 0) 
    caller_idx = game.current_turn
    game.next_turn
    count = game.players.count
    last = game.poker_moves.last(count)
    if last.all? { |move| move.move == 'call' }
      case round.round_number
      when 1
        game.players.each do |player|
          ActionCable.server.broadcast "room_channel_#{player}",
                                        call: true
        end
        ActionCable.server.broadcast "room_channel_#{game.players[current_user.id]}",
                                      turn: false                            
      when 2
        game.players.each do |player|
          ActionCable.server.broadcast "room_channel_#{player}",
                                        card_turn: true
        end
      when 3
        game.players.each do |player|
          ActionCable.server.broadcast "room_channel_#{player}",
                                        river: true
        end
        ActionCable.server.broadcast "room_channel_#{game.players[game.current_turn]}",
                                    turn: true                                
      end
      game.next_betting_round
    else
      ActionCable.server.broadcast "room_channel_#{current_user.id}",
                                    turn: false
      ActionCable.server.broadcast "room_channel_#{game.players[game.current_turn]}",
                                    turn: true                          
    end
  end

  def fold
  end

  def flop
    room = current_user.current_room
    game = PokerGame.find_by(poker_room_id: room)
    @flop = [Card.find(game.flop_1), Card.find(game.flop_2), Card.find(game.flop_3)]
  end

  def card_turn
    room = current_user.current_room
    game = PokerGame.find_by(poker_room_id: room)
    @turn = Card.find(game.flop_4)
  end

  def river
    room = current_user.current_room
    game = PokerGame.find_by(poker_room_id: room)
    @river = Card.find(game.flop_5)
  end

  # def get_messages 
  #   @messages = Message.for_display 
  #   @message = current_user.messages.build 
  # end

  private
    def current_room
      PokerRoom.find_by(id: current_user.current_room) 
    end 

    def current_game
      PokerGame.find_by(poker_room_id: current_room.current_poker_game_id)
    end

    def player_bet
      current_round.current_player(current_user.id).current_bet
    end
end
  
