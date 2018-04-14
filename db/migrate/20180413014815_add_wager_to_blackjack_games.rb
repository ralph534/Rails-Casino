class AddWagerToBlackjackGames < ActiveRecord::Migration[5.1]
  def change
    add_column :blackjack_games, :wager, :integer, default: 1
  end
end
