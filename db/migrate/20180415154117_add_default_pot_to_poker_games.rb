class AddDefaultPotToPokerGames < ActiveRecord::Migration[5.1]
  def change
    change_column :poker_games, :pot, :integer, default: 0
  end
end
