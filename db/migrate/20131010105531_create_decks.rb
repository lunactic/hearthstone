class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.string :deck_type

      t.timestamps
    end

    create_table :cards_decks do |t|
      t.belongs_to :deck
      t.belongs_to :card
    end
  end

end
