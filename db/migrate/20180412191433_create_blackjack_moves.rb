class CreateBlackjackMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :blackjack_moves do |t|
      t.references :user, foreign_key: true
      t.boolean :stay
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
