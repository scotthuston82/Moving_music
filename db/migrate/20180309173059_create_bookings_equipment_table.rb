class CreateBookingsEquipmentTable < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings_equipment do |t|
      t.integer :booking_id
      t.integer :equipment_id
    end
  end
end
