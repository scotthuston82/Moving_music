class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment do |t|
      t.integer :user_id
      t.string :category
      t.string :details
      t.integer :price
      t.timestamps
    end
  end
end
