class AddUserRefToStatEntries < ActiveRecord::Migration
  def change
    add_reference :stat_entries, :user, index: true
  end
end
