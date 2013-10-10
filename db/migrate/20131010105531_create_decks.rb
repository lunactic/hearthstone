class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.string :deck_type

      t.timestamps
    end
  end
end
