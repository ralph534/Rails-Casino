class CreateBettingRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :betting_rounds do |t|
      t.references :poker_game, foreign_key: true
      t.integer :round_number
      t.string :player_1_decision
      t.string :player_2_decision
      t.string :player_3_decision
      t.string :player_4_decision
      t.string :player_5_decision
      t.string :player_6_decision
      t.string :player_7_decision
      t.string :player_8_decision
      t.timestamps
    end
  end
end
