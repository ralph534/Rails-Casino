class AddCardIdColumnToDeckCards < ActiveRecord::Migration[5.1]
  def change
    add_column :deck_cards, :card_id, :integer
  end
end
