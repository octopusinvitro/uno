require "sinatra"
require "json"
require "rest-client"

require "./lib/messages"
require "./lib/deck"
require "./lib/uno_server"
require "./lib/uno_client"
require "./lib/main"
run Main
