require 'sinatra'
require 'json'
require 'alexa_rubykit'

before do
  content_type 'application/json'
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
    response.add_speech("I received an intent named #{request.name}?")
    response.add_hash_card( { title: 'Ruby Intent', subtitle: "Intent #{request.name}" } )
  end

  if (request.type =='SESSION_ENDED_REQUEST')
    halt 200
  end

  response.build_response
end