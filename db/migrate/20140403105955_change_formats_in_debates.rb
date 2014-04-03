class ChangeFormatsInDebates < ActiveRecord::Migration
  def up
    change_column :debates, :content, :text
    change_column :debates, :affirmative, :text
    change_column :debates, :negative, :text
  end

  def down
    change_column :debates, :content, :string
    change_column :debates, :affirmative, :string
    change_column :debates, :negative, :string
  end
end
