class AddColumnsToPokerMoves < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_moves, :raise_amt, :integer
  end
end
