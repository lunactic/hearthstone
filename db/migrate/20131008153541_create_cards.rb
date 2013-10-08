class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :card_class
      t.string :card_type
      t.string :rarity
      t.integer :cost
      t.integer :attack
      t.integer :health
      t.integer :description

      t.timestamps
    end
  end
end
