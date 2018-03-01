class AddNameToStyles < ActiveRecord::Migration[5.1]
  def change
    change_table :styles do |t|
      t.string :name
    end
  end
end
