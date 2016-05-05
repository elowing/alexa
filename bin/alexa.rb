require 'sinatra'
require 'json'
require 'alexa_rubykit'
require_relative '../lib/dadjokes'

before do
  content_type 'application/json'
end

set :port, 8445

get '/' do
  "These will be dad jokes. Nothing to see here yet, move along."
end

post '/' do
  request_json = JSON.parse request.body.read.to_s
  request = AlexaRubykit.build_request request_json

  response = AlexaRubykit::Response.new
  if (request.type == 'LAUNCH_REQUEST')
    response.add_speech('Ruby running ready!')
    response.add_hash_card( { title: 'Ruby Run', subtitle: 'Ruby Running Ready!' } )
  end

  if (request.type == 'INTENT_REQUEST')
    client = DadJokes.new
    client.user_timeline("baddadjokes")
    require 'pry'; binding.pry
    response.add_speech("I received an intent named #{request.name}?")
    response.add_hash_card( { title: 'Ruby Intent', subtitle: "Intent #{request.name}" } )
  end

  if (request.type =='SESSION_ENDED_REQUEST')
    halt 200
  end

  response.build_response
end
