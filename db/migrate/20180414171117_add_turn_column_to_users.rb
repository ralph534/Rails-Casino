class AddTurnColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :turn, :boolean, default: false
  end
end
