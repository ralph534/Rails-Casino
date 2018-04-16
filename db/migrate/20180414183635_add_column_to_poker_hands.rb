class AddColumnToPokerHands < ActiveRecord::Migration[5.1]
  def change
    add_column :poker_hands, :poker_game_id, :integer
  end
end