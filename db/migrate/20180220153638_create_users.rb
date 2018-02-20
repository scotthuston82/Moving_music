class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :kind
      t.string :profile_picture
      t.text :bio
      t.float :hourly_rate_in_cents
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
