class CreatePokerMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :poker_moves do |t|
      t.references :user, foreign_key: true
      t.references :poker_game, foreign_key: true

      t.timestamps
    end
  end
end
