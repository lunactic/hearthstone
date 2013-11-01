class CreateCardDecks < ActiveRecord::Migration
  def change
    create_table :card_decks do |t|
      t.references :card, index: true
      t.references :deck, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
