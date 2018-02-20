class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :musician_id
      t.integer :client_id
      t.boolean :confirmed
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :client_review
      t.text :musician_review
      t.integer :party_size
      t.string :age_range
      t.timestamps
    end
  end
end
