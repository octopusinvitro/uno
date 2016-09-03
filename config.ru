require "sinatra"
require "json"
require "rest-client"

require "./lib/constants"
require "./lib/messages"
require "./lib/deck"
require "./lib/uno"
require "./lib/uno_server"
require "./lib/uno_client"
require "./lib/main_helper"
require "./lib/page/index"
require "./lib/page/join"
require "./lib/page/deal"
require "./lib/main"

run Main.new(MainHelper.new(UnoServer.new(Uno.new)))
