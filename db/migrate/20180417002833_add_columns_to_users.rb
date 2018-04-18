class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string
    add_column :users, :public_key, :string
    add_column :users, :private_key, :string
  end
end
