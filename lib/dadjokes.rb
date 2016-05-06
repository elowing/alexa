class DadJokes
  require 'twitter'

  attr_reader :client

  USER = 'baddadjokes'

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  def sample
    format jokes.sample
  end

  private

  def jokes
    @jokes ||= select_original_tweet_text client.user_timeline(USER)
  end

  def select_original_tweet_text(jokes)
    jokes.reject(&:retweet?).reject(&:reply?).map(&:text)
  end

  def format(joke)
    joke.drop_hashtags.remove_mentions.remove_whitespace
  end

  def drop_hashtags(joke)
    joke.split('#').first
  end

  def remove_mentions(joke)
    joke.gsub(/@\w+\b/,'')
  end

  def remove_whitespace(joke)
    joke.gsub(/\s+/, " ").strip
  end
end
