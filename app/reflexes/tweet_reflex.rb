# frozen_string_literal: true

class TweetReflex < ApplicationReflex
  include CableReady::Broadcaster
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def like
    tweet = Tweet.find(element.dataset[:id])
    tweet.increment! :likes
    cable_ready["timeline"].text_content(
      selector: "#tweet-#{tweet.id}-likes",
      text: tweet.likes
    )
    cable_ready.broadcast
  end

  def delete
    tweet = Tweet.find(element.dataset[:id])
    tweet.delete
    cable_ready["timeline"].remove(
      selector: "#tweet-#{tweet.id}"
    )
    cable_ready.broadcast
  end

  def update
    tweet = Tweet.find(element.dataset[:id])
    cable_ready["tweet-show"].text_content(
      selector: "#tweet-#{tweet.id}",
      likes: tweet.likes,
      content: tweet.content
    )
    cable_ready.broadcast
  end
end
