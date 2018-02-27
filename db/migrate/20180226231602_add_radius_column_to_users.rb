class AddRadiusColumnToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :radius, :float
  end

  def down
    remove_column :users, :radius, :float
  end
end
