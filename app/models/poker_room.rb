class PokerRoom < ApplicationRecord
  # after_create :start_game

  # def start_game
  #   PokerGame.create(poker_room_id: self.id, player1: self.player1, player2: self.player2,
  #                    player3: self.player3, player4: self.player4, player5: self.player5,
  #                    player6: self.player6, player7: self.player7, player8: self.player8)
  # end

  def players
    players = [self.player1, self.player2, self.player3, self.player4,
               self.player5, self.player6, self.player7, self.player8]
  end
end
