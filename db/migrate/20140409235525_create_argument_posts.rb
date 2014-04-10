class CreateArgumentPosts < ActiveRecord::Migration
  def change
    create_table :argument_posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :debate_id
      t.string :type

      t.timestamps
    end
    add_index :argument_posts, [:debate_id, :user_id, :created_at]
  end
end
