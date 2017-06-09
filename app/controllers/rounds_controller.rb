class RoundsController < ApplicationController

  def create
    round_key = Round.makeKey
    round = Round.new(key: round_key)
    session[:creator] = true
    if round.save
      redirect_to round
    else
      redirect '/'
    end
  end

  def show
    if session[:creator]
      @round = Round.find(params[:id])
    else
      @round = Round.find(params[:id])
      # ActionCable.server.broadcast "rounds_channel_#{@round.id}",
      #                             name: User.find(session[:user_id]).name
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

    # if request.xhr?
    #   ActionCable.server.broadcast "rounds_channel_#{@round.id}",
    #                               restaurants: @restaurants
    # else

    # end
  end

  def results
    @round = Round.find(params[:id])
    @round.update_attribute(:completed, true)

  end
end
