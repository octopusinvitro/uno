require "sinatra"
require "json"
require "rest-client"

require "./lib/uno/constants"
require "./lib/uno/deck"
require "./lib/uno/uno"
require "./lib/uno/uno_server"
require "./lib/uno/uno_client"
require "./lib/page/messages"
require "./lib/page/error"
require "./lib/page/index"
require "./lib/page/join"
require "./lib/page/deal"
require "./lib/page/cards"
require "./lib/main_helper"
require "./lib/main"

run Main.new(MainHelper.new(UnoServer.new(Uno.new)))
