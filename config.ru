require "sinatra"
require "json"
require "rest-client"

require "./lib/messages"
require "./lib/deck"
require "./lib/uno"
require "./lib/uno_server"
require "./lib/uno_client"
require "./lib/main_helper"
require "./lib/main"

run Main.new(MainHelper.new(UnoServer.new(Uno.new)))
