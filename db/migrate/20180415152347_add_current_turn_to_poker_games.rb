class AddCurrentTurnToPokerGames < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_games, :current_turn, :integer, default: 0
  end
end
