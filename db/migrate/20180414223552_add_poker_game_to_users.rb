class AddPokerGameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :poker_game, :integer, foreign_key: true
  end
end
