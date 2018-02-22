class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :gigs, class_name: 'Booking', foreign_key: :musician_id
  has_many :events, class_name: 'Booking', foreign_key: :client_id
  has_many :musician_reviews, class_name:'Review', foreign_key: :musician_id
  has_many :client_reviews, class_name:'Review', foreign_key: :client_id


end
