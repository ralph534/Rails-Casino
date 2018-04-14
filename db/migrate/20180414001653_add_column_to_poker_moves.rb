class AddColumnToPokerMoves < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_moves, :betting_round, :integer
    add_column :poker_moves, :move, :string
  end
end
