class DadJokes
  require 'twitter'

  attr_reader :client

  USER = 'baddadjokes'

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "fgLnjh2HeNO9EvXlqP9YveldC"
      config.consumer_secret     = "UwALbYO4AJVgu57DbMPAdn6NYynCA2SOv1CDe8YB7l1CysmMWk"
      config.access_token        = "2397151184-paF7axOUYXvye6lDc1FnT82FbdQfEuh8YAv9nRz"
      config.access_token_secret = "tfjnBOXUszQVgFcxfT9Nhwgh6EWwSnPIpohkHpZ6zZMPQ"
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
