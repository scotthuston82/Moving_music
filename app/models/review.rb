class Review < ApplicationRecord
  belongs_to :musician, class_name: 'User'
  belongs_to :client, class_name: 'User'
end
