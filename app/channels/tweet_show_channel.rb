class TweetShowChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tweet_show_channel"
  end
end
