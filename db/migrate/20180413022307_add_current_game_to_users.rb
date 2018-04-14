class AddCurrentGameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :game, foreign_key: true
  end
end
