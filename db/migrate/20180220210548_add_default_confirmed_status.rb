class AddDefaultConfirmedStatus < ActiveRecord::Migration[5.1]
  def up
    change_table :bookings do |t|
      t.remove :confirmed
      t.boolean :confirmed, :default => false
    end
  end

  def down
    change_table :bookings do |t|
      t.remove :confirmed
      t.boolean :confirmed
    end
  end

end
