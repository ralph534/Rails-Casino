class AddValueToBlackjackHands < ActiveRecord::Migration[5.1]
  def change
    add_column :blackjack_hands, :value, :integer
  end
end
