class AddUserRefToDecks < ActiveRecord::Migration
  def change
    add_reference :decks, :user, index: true
  end
end
