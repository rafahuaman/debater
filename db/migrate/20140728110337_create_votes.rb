class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :type
      t.integer :subject_id
      t.integer :value
      t.references :user, index: true

      t.timestamps
    end
  end
end
