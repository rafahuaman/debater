class AddParentIdToArgumentPosts < ActiveRecord::Migration
  def change
    add_column :argument_posts, :parent_id, :integer
    add_index :argument_posts, [:parent_id]
  end
end
