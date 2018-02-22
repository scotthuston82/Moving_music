class DropStylesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :styles
  end
end
