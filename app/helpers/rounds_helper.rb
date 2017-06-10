module RoundsHelper

  def get_restaurants(round)
    @location = RestClient.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV["GOOGLE_LOCATION_TOKEN"]}", nil)
    @location = JSON.parse(@location)
    @location =  @location["location"]
    @response = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@location["lat"]},#{@location["lng"]}&radius=500&type=restaurant&key=#{ENV["GOOGLE_PLACES_TOKEN"]}")
    @response = JSON.parse(@response)
    @response = @response["results"]
    @response.each do |restaurant|
      p restaurant
      Restaurant.create(name: restaurant["name"], rating: restaurant["rating"], price: restaurant["price_level"], address: restaurant["vicinity"], round_id: round.id)
    end
  end

end
