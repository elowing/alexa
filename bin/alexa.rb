require 'json'
require 'dotenv'
require 'sinatra'
require 'alexa_rubykit'
require_relative '../lib/dadjokes'

Dotenv.load

before do
  content_type 'application/json'
end

set :port, 8445

get '/' do
  "Dad jokes coming. Nothing to see here yet, move along."
end

post '/' do
  request_json = JSON.parse request.body.read.to_s
  request = AlexaRubykit.build_request request_json

  response = AlexaRubykit::Response.new
  if (request.type == 'LAUNCH_REQUEST')
    response.add_speech('Ruby running ready!')
    response.add_hash_card( { title: 'Ruby Launch', subtitle: 'Ruby Launching!' } )
  end

  if (request.type == 'INTENT_REQUEST')
    joke = DadJokes.new.sample
    response.add_speech joke
    response.add_hash_card( { title: 'Ruby Intent', content: joke } )
  end

  if (request.type =='SESSION_ENDED_REQUEST')
    halt 200
  end

  response.build_response
end
