class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references  :votable, polymorphic: true
      t.integer :value
      t.references :user, index: true

      t.timestamps
    end
  end
end
