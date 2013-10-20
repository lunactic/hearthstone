class CreateStatEntries < ActiveRecord::Migration
  def change
    create_table :stat_entries do |t|
      t.string :hero
      t.string :opp_hero
      t.string :game_mode
      t.string :result
      t.boolean :first
      t.date :created_at

      t.timestamps
    end
  end
end
