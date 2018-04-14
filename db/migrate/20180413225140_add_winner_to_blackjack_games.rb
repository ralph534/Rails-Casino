class AddWinnerToBlackjackGames < ActiveRecord::Migration[5.1]
  def change
    add_column :blackjack_games, :winner, :string, default: nil
  end
end
