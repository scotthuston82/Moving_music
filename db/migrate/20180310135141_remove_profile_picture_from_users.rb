class RemoveProfilePictureFromUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :profile_picture, :string
  end

  def down
    add_column :users, :profile_picture, :string
  end
end
