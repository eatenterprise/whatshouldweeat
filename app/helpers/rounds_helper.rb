module RoundsHelper
  def get_restaurants(round, location)
    response = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location[:lat]},#{location[:lng]}&radius=#{location[:radius]}&type=restaurant&key=#{ENV["GOOGLE_PLACES_TOKEN"]}")
    response = JSON.parse(response)
    # additional_results(response, round) # Google places API call returns 20 results max, can use this method to get more, but makes things much slower
    create_restaurants(response, round)
  end

  # def get_location(location)
  #   @location = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{location[:street]},+#{location[:city]},+#{location[:state]}&key=#{ENV["GOOGLE_GEOCODING_TOKEN"]}")
  #   @location = JSON.parse(@location)
  #   if @location["status"] == "ZERO_RESULTS"
  #     return nil
  #   end
  #   @lat = @location["results"][0]["geometry"]["location"]["lat"]
  #   @lng = @location["results"][0]["geometry"]["location"]["lng"]
  #   {lat: @lat, lng: @lng}
  # end

  def valid_location?(location)
    !@location["status"] == "ZERO_RESULTS"
  end

  def additional_results(response, round)
    if response['next_page_token']
      sleep(1.5) # Can't call the API too quickly with a pagetoken query or it returns invalid request
      more_restaurants = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=#{response['next_page_token']}&key=#{ENV["GOOGLE_PLACES_TOKEN"]}")
      more_restaurants = JSON.parse(more_restaurants)
      additional_results(more_restaurants, round)
      create_restaurants(more_restaurants, round)
    end
  end

  def create_restaurants(json_response, round)
    response = json_response["results"]
    response.each do |restaurant|
      Restaurant.create(name: restaurant["name"], rating: restaurant["rating"], price: restaurant["price_level"], address: restaurant["vicinity"], round_id: round.id)
    end
  end
end
