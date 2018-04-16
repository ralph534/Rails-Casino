class RenamePokerRoomColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :poker_rooms, :current_round, :current_poker_game_id
  end
end
