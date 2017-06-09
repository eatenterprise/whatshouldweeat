class RoundsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"

    stream_from "rounds_channel_#{params[:round_id]}"
    puts "Streaming from rounds_channel_#{params[:round_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
