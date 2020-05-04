class LikeReflex < StimulusReflex::Reflex
  def like
    @tweet_id = element.dataset[:tweet]
    @tweet = Tweet.find(@tweet_id)
    @tweet.likes = @tweet.likes + 1
    @tweet.save
    @like_count = 33
  end
end
