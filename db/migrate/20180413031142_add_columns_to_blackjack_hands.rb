class AddColumnsToBlackjackHands < ActiveRecord::Migration[5.1]
  def change
    add_column :blackjack_hands, :card3_id, :integer
    add_column :blackjack_hands, :card4_id, :integer
    add_column :blackjack_hands, :card5_id, :integer
    add_column :blackjack_hands, :card6_id, :integer
    add_column :blackjack_hands, :card7_id, :integer
  end
end
