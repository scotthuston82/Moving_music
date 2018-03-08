class AddEventNameToBookings < ActiveRecord::Migration[5.1]
  def up
    add_column :bookings, :event_name, :string
  end

  def down
    remove_column :bookings, :event_name, :string
  end
end
