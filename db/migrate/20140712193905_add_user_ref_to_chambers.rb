class AddUserRefToChambers < ActiveRecord::Migration
  def change
    add_reference :chambers, :user, index: true
  end
end
