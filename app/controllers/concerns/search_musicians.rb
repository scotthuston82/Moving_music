class SearchMusicians

  attr_reader :results

  def initialize(params)
    @params = params
    @results = musicians_by_distance
    filter_by_act_type
    filter_by_genres
  end

  def musicians_by_distance
    musicians = User.where('kind = ?', 'musician')
    event_coordinates = Geocoder.search(@params[:booking][:address]).first.coordinates
    musicians.select do |musician|
      Geocoder::Calculations.distance_between(
        event_coordinates,
        musician.to_coordinates,
        units: :km
      ) < @params[:radius].to_i
    end
  end

  def filter_by_act_type
    # binding.pry
    @results.select! do |musician|
      musician.act_type == @params[:act_type]
    end
  end

  def filter_by_hourly_rate
    # binding.pry
    @results.select! do |musician|
      musician.act_type == @params[:hourly_rate]
    end
  end

  def filter_by_genres
    genre_ids = @params[:musician][:genre_ids][1..-1].map(&:to_i)
    @results.select! do |musician|
      genre_ids.all? { |id| musician.genre_ids.include?(id) }
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
