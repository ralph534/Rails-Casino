class AddCardColumnsToPokerGame < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_games, :flop_1, :integer
    add_column :poker_games, :flop_2, :integer
    add_column :poker_games, :flop_3, :integer
    add_column :poker_games, :flop_4, :integer
    add_column :poker_games, :flop_5, :integer
  end
end