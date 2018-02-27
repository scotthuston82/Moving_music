class AddAddressColumnToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :address, :string
  end

  def down
    remove_column :users, :address, :string
  end
end
