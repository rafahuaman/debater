class AddIndexToDebates < ActiveRecord::Migration
  def change
    add_index :debates, :chamber_id
  end
end
