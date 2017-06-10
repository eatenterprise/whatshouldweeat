class RoundsController < ApplicationController

  def create
    round_key = Round.makeKey
    round = Round.new(key: round_key)
    User.create(name: params[:name], round_id: round.id)
    session[:creator] = true
    location = helpers.get_location({street: params[:street], city: params[:city], state: params[:state]})
    if location && round.save
      helpers.get_restaurants(round, location)
      redirect_to round
    else
      redirect_to '/'
    end
  end

  def show
    if session[:creator]
      @round = Round.find(params[:id])
    else
      @round = Round.find(params[:id])
    end
  end


  def destroy
  end

  def find_key
    @round = Round.find_by(key: params[:key])
    @user = User.create(name: params[:name], round_id: @round.id) if @round
    session[:user_id] = @user.id
    redirect_to @round
  end

  def start
    @round = Round.find(params[:round_id])
    @restaurants = @round.restaurants
  end

  def results
    @round = Round.find(params[:id])
    @round.update_attribute(:completed, true)
    @winner = @round.restaurants.order(votes: :desc).limit(1).first
    @winner.update_attribute(:winner, true)
  end

end
