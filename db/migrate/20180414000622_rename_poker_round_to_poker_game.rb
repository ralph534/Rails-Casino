class RenamePokerRoundToPokerGame < ActiveRecord::Migration[5.1]
  def change
    rename_table :poker_rounds, :poker_games
  end
end
