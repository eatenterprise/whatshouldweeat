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
      @round = Round.find_by(key: params[:key])

      @user = User.create(name: params[:name], round: @round)
      ActionCable.server.broadcast "rounds_channel_#{@round.id}",
                                  name: @user.name

    end
  end


  def destroy
  end

  def find_key
    round = Round.find_by(key: params[:key])
    redirect_to round
  end
end
