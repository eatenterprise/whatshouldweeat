require 'rest-client'

class RestaurantsController < ApplicationController
  def update
    restaurant = Restaurant.find(params[:id])
    votes = restaurant.votes
    restaurant.update_attribute(:votes, votes + 1)
    session[params[:name]] = true
    if request.xhr?

    else

    end
  end
end
