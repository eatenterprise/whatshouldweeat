class RoundsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    p params
    puts "***********"
    stream_from "rounds_channel_#{params[:round_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
