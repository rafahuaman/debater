class CreateChambers < ActiveRecord::Migration
  def change
    create_table :chambers do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
