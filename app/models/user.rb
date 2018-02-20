class User < ApplicationRecord
  def change
    create_table :Users do |t|
      t.string :email
      t.string :password_digest
      t.string :kind
      t.string :profile_picture
      t.text   :bio
      t.float  :rate_per_hour_in_cents
      t.float  :latitude
      t.float  :longitude
    end
  end
end
