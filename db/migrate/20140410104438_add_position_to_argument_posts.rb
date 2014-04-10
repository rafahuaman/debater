class AddPositionToArgumentPosts < ActiveRecord::Migration
  def change
    add_column :argument_posts, :position, :string
  end
end
