module RoundsHelper

  def get_restaurants(round, location)
    p location
    @response = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location[:lat]},#{location[:lng]}&radius=500&type=restaurant&key=#{ENV["GOOGLE_PLACES_TOKEN"]}")
    puts "response is #{@response}"
    @response = JSON.parse(@response)
    @response = @response["results"]
    @response.each do |restaurant|
      Restaurant.create(name: restaurant["name"], rating: restaurant["rating"], price: restaurant["price_level"], address: restaurant["vicinity"], round_id: round.id)
    end
  end

  def get_location(location)
    @location = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{location[:street]},+#{location[:city]},+#{location[:state]}&key=#{ENV["GOOGLE_GEOCODING_TOKEN"]}")
    @location = JSON.parse(@location)
    if @location["status"] == "ZERO_RESULTS"
      return nil
    end
    @lat = @location["results"][0]["geometry"]["location"]["lat"]
    @lng = @location["results"][0]["geometry"]["location"]["lng"]
    {lat: @lat, lng: @lng}
  end

  def valid_location?(location)
    !@location["status"] == "ZERO_RESULTS"
  end

end
