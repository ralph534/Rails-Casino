class AddHandToBlackjackMoves < ActiveRecord::Migration[5.1]
  def change
    add_reference :blackjack_moves, :blackjack_hand, foreign_key: true
  end
end
