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

end
