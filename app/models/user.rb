class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :kind, :presence => { message: 'specify if you are a musician or a client!' }
  validate :kind_must_only_be_musician_or_client
  validate :musician_act_type_can_only_be_dj_or_band
  validate :musician_hourly_rate_must_be_greater_than_zero

  has_many :gigs, class_name: 'Booking', foreign_key: :musician_id
  has_many :events, class_name: 'Booking', foreign_key: :client_id
  has_many :musician_reviews, class_name:'Review', foreign_key: :musician_id
  has_many :client_reviews, class_name:'Review', foreign_key: :client_id

  has_and_belongs_to_many :genres

  def kind_must_only_be_musician_or_client
    if self[:kind] != 'musician' && self[:kind] != 'client'
      errors.add(:kind, "can only be 'musician' or 'client'")
    end
  end

  def musician_act_type_can_only_be_dj_or_band
    if self[:kind] == 'musician' && self[:act_type] && self[:act_type] != 'dj' && self[:act_type] != 'band'
      errors.add(:act_type, "can only be 'dj' or 'band'")
    end
  end

  # NEED TEST FOR THIS!
  def musician_hourly_rate_must_be_greater_than_zero
    if self[:kind] == 'musician' && self[:hourly_rate] && self[:hourly_rate] <= 0
      errors.add(:hourly_rate, 'must be greater than zero')
    end
  end
  
  def self.filtre_musicians(act_type, hourly_rate, genres_array, array_of_musicians)
  genre_musicians = []
  genres_array.delete("") #collection checkboxes always gives empty string as first value. Don't ask why
  musicians = User.where("kind = ? AND act_type = ? AND hourly_rate <= ?", "musician", act_type, hourly_rate)
  musicians = musicians.as_json
  if genres_array.size > 0
    genres_array.each do |genre_id|
      genre_musicians << musicians.joins(:genres).where(genres: {id: genre_id})
    end
    musicians = genre_musicians.reduce do |common_musicians, genre_list|
      common_musicians & genre_list
    end
  end
  final_musicians_list = []
  musicians.each do |musician_a|
    array_of_musicians.each do |musician_b|
      if musician_a[:id] == musician_b[:id]
        user = User.new
        print user.from_json(musician_a.to_json)
        final_musicians_list << user.from_json(musician_a.to_json)
      end
    end
  end
  return final_musicians_list.uniq
end

end
