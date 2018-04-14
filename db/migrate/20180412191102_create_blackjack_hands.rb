class CreateBlackjackHands < ActiveRecord::Migration[5.1]
  def change
    create_table :blackjack_hands do |t|
      t.references :blackjack_game, foreign_key: true
      t.integer :card1_id
      t.integer :card2_id
      t.string :holder

      t.timestamps
    end
  end
end
