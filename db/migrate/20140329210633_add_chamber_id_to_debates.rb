class AddChamberIdToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :chamber_id, :integer
  end
end
