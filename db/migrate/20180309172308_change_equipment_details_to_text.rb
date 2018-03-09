class ChangeEquipmentDetailsToText < ActiveRecord::Migration[5.1]
  def up
    change_column :equipment, :details, :text
  end

  def down
    change_column :equipment, :details, :string
  end
end
