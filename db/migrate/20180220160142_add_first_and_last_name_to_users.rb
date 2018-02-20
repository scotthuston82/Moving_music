class AddFirstAndLastNameToUsers < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
    end
  end

  def down
    change_table :users do |t|
      t.remove :first_name
      t.remove :last_name      
    end
  end
end
