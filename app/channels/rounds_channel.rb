class RoundsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rounds_channel_#{params[:round_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def joined
    count = Round.find(params[:round_id]).users.count
    voted = Round.find(params[:round_id]).finished_voting_count
    ActionCable.server.broadcast "rounds_channel_#{params[:round_id]}",
                                  total_users: count,
                                  finished_count: voted
  end
end
