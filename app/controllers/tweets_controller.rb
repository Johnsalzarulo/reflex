class TweetsController < ApplicationController
  include CableReady::Broadcaster

  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    tweet = Tweet.create(tweet_params)
    cable_ready["timeline"].insert_adjacent_html(
      selector: "#timeline",
      position: "afterbegin",
      html: render_to_string(partial: "tweet", locals: {tweet: tweet})
    )
    cable_ready.broadcast
    redirect_to tweets_path
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    if @tweet.update(tweet_params)
      cable_ready["timeline"].inner_html(
        selector: "#tweet-#{@tweet.id}",
        html: render_to_string(partial: "tweet", locals: {tweet: @tweet})
      )
      cable_ready.broadcast
      redirect_to @tweet, notice: 'Tweet was successfully updated.'
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :likes)
    end
end
