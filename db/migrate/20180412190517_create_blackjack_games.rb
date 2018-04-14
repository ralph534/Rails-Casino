class CreateBlackjackGames < ActiveRecord::Migration[5.1]
  def change
    create_table :blackjack_games do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
