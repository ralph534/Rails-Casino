class CreatePokerHands < ActiveRecord::Migration[5.1]
  def change
    create_table :poker_hands do |t|
      t.references :poker_round, foreign_key: true
      t.integer :card1_id
      t.integer :card2_id
      t.references :user, foreign_key: true
      t.integer :wager

      t.timestamps
    end
  end
end
