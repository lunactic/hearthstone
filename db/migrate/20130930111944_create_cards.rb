class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :cost
      t.string :class
      t.string :race
      t.string :type
      t.integer :attack
      t.integer :health
      t.string :rarity

      t.timestamps
    end
  end
end
