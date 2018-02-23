class AddActTypeToUsers < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.string :act_type
    end
  end

  def down
    change_table :users do |t|
      t.remove :act_type
    end
  end
end
