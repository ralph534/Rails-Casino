class CreateDeckCards < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_cards do |t|
      t.references :deck, foreign_key: true
      t.references :poker_game, foreign_key: true
      t.boolean :drawn

      t.timestamps
    end
  end
end
