require 'rest-client'

class RestaurantsController < ApplicationController

  def create
    puts "params are #{params}"
    @restaurant = Restaurant.new(name: params[:name], round_id: params[:round_id])
    @restaurant.save
    puts "restaurant is #{@restaurant}"
    if request.xhr?
      render :json => {
        restaurant: @restaurant
      }
    else

    end
  end

  def find_nearby
    @location = RestClient.post("https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV["GOOGLE_LOCATION_TOKEN"]}", nil)
    @location = JSON.parse(@location)
    @location =  @location["location"]
    @response = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@location["lat"]},#{@location["lng"]}&radius=500&type=restaurant&key=#{ENV["GOOGLE_PLACES_TOKEN"]}")
    @response = JSON.parse(@response)
    @response = @response["results"]
    p @response[1]
    p @response[1]["name"]
    p @response[1]["rating"]
    p @response[1]["price_level"]
    render 'nearby_restaurants'
  end

end
