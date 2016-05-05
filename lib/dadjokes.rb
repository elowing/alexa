class DadJokes
  require 'twitter'

  def initialize
    Twitter::REST::Client.new do |config|
      config.consumer_key        = "fgLnjh2HeNO9EvXlqP9YveldC"
      config.consumer_secret     = "UwALbYO4AJVgu57DbMPAdn6NYynCA2SOv1CDe8YB7l1CysmMWk"
      config.access_token        = "2397151184-paF7axOUYXvye6lDc1FnT82FbdQfEuh8YAv9nRz"
      config.access_token_secret = "tfjnBOXUszQVgFcxfT9Nhwgh6EWwSnPIpohkHpZ6zZMPQ"
    end
  end
end
