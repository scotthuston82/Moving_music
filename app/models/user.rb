class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :kind, :presence => { message: 'specify if you are a musician or a client!' }

  has_many :gigs, class_name: 'Booking', foreign_key: :musician_id
  has_many :events, class_name: 'Booking', foreign_key: :client_id
  has_many :musician_reviews, class_name:'Review', foreign_key: :musician_id
  has_many :client_reviews, class_name:'Review', foreign_key: :client_id

  has_and_belongs_to_many :genres

  def self.filtre_musicians(act_type, hourly_rate, genres_array)
    genre_musicians = []
    genres_array.delete("") #collection checkboxes always gives empty string as first value. Don't ask why
    musicians = User.where("kind = ? AND act_type = ? AND hourly_rate <= ?", "musician", act_type, hourly_rate)
    if genres_array.size > 0
      genres_array.each do |genre_id|
        genre_musicians << musicians.joins(:genres).where(genres: {id: genre_id})
      end
      musicians = genre_musicians.reduce do |common_musicians, genre_list|
        common_musicians & genre_list
      end
    end

    return musicians.uniq
  end

end
