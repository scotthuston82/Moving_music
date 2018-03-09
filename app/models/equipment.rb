class Equipment < ApplicationRecord
  CATEGORY_OPTIONS = [
    "Soundboard / PA",
    "Lighting Rig"
  ]

  belongs_to :musician, class_name: 'User'
  has_and_belongs_to_many :bookings
end
