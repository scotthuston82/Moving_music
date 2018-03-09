class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  geocoded_by :address
  after_validation :geocode
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :kind, :presence => { message: 'specify if you are a musician or an event planner!' }
  validates :act_type, presence: true, if: :user_type_is_musician?
  validates :hourly_rate, presence: true, if: :user_type_is_musician?
  validates :hourly_rate, numericality: { greater_than: 0 }, if: :user_type_is_musician?
  validate :kind_must_only_be_musician_or_client
  validate :musician_act_type_can_only_be_dj_or_band, if: :user_type_is_musician?
  validate :musician_address_must_be_valid, if: :user_type_is_musician?

  has_many :gigs, class_name: 'Booking', foreign_key: :musician_id
  has_many :events, class_name: 'Booking', foreign_key: :client_id
  has_many :musician_reviews, class_name:'Review', foreign_key: :musician_id
  has_many :client_reviews, class_name:'Review', foreign_key: :client_id
  has_many :equipments, foreign_key: :musician_id

  has_and_belongs_to_many :genres

  def kind_must_only_be_musician_or_client
    if self[:kind] != 'musician' && self[:kind] != 'client'
      errors.add(:kind, "can only be 'musician' or 'client'")
    end
  end

  def musician_act_type_can_only_be_dj_or_band
    if self[:act_type] != 'dj' && self[:act_type] != 'band'
      errors.add(:act_type, "can only be 'dj' or 'band'")
    end
  end

  def musician_address_must_be_valid
    results = Geocoder.search(self[:address])
    unless results.any?
      errors.add(:address, 'must be valid')
    end
  end

  def user_type_is_musician?
    if self[:kind] == 'musician'
      return true
    else
      return false
    end
  end
end
