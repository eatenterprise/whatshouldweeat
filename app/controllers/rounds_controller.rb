class RoundsController < ApplicationController
skip_before_action :verify_authenticity_token

  def create
    location = {lat: params[:lat], lng: params[:lng], radius: params[:radius]}
    round_key = Round.makeKey
    round = Round.new(key: round_key)
    session[:creator] = true
    if location && round.save
      helpers.get_restaurants(round, location)
      if round.restaurants.length > 0
        redirect_to round
      else
        @error = "No results!"
        flash.now[:notice] = 'No results!'
        render 'home/index'
      end
    else
      redirect_to '/'
    end
  end

  def show
    @round = Round.find(params[:id])
    if @round.completed
      @winner = @round.restaurants.find_by(winner: :true)
      render 'results'
    else
      if session[:user_id].nil?
        @user = User.create(name: 'abc', round_id: params[:id])
        session[:user_id] = @user.id
      else
        @user = User.find(session[:user_id])
      end
      render 'show'
    end
  end


  def destroy
  end

  def find_key
    @round = Round.find_by(key: params[:key])
    # @user = User.create(name: params[:name], round_id: @round.id) if @round
    # session[:user_id] = @user.id
    if @round
      redirect_to @round
    else
      redirect_to '/'
    end
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
    @winner_page = render 'rounds/results', locals: { winner: @winner }
    ActionCable.server.broadcast "rounds_channel_#{@round.id}",
                                  body: @winner_page
    @round.users.each{|u| u.destroy}
    @round.restaurants.where(winner: nil).each{ |r| r.destroy}
  end

  def finish_voting
    @round = Round.find(params[:id])
    
    if session[:voted].nil?
      session[:voted] = true
      count = @round.finished_voting_count
      @round.update_attribute(:finished_voting_count, count + 1)
    end
     
    new_count = @round.finished_voting_count
    total_users = @round.users.count
    puts "reached asdf sdaf dsfoh asdlfjb sadlfjb asdf sadf"
    ActionCable.server.broadcast "rounds_channel_#{@round.id}",
                                  checked: true,
                                  finished_count: new_count,
                                  total_users: total_users
  end
end
