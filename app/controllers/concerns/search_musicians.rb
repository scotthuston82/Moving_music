class SearchMusicians

  attr_reader :results

  def initialize(params)
    @params = params
    if @params[:booking][:address] == ""
      @results = User.where('kind = ?', 'musician').to_a
    else
      @results = musicians_by_distance
    end
    if @params[:act_type] != ""
      filter_by_act_type
    end
    if @params[:hourly_rate] != ""
      filter_by_hourly_rate
    end
    if @params[:musician][:genre_ids] != [""]
      filter_by_genres
    end
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
    @results.select! do |musician|
      musician.act_type == @params[:act_type]
    end
  end

  def filter_by_hourly_rate
    @results.select! do |musician|
      musician.hourly_rate <= @params[:hourly_rate].to_i
    end
  end

  def filter_by_genres
    genre_ids = @params[:musician][:genre_ids][1..-1].map(&:to_i)
    @results.select! do |musician|
      genre_ids.all? { |id| musician.genre_ids.include?(id) }
    end
  end

end
