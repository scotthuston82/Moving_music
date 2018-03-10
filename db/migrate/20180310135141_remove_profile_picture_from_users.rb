class RemoveProfilePictureFromUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :profile_picture, :string
    remove_column :users, :avatar, :string
  end

  def down
    add_column :users, :profile_picture, :string
    add_column :users, :avatar, :string
  end
end
