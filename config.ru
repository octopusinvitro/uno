# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'rest-client'

require './lib/uno/constants'
require './lib/uno/deck'
require './lib/uno/player'
require './lib/uno/player_factory'
require './lib/uno/game'
require './lib/uno/server'
require './lib/uno/client'
require './lib/response/join'
require './lib/response/deal'
require './lib/response/cards'
require './lib/page/messages'
require './lib/page/error'
require './lib/page/index'
require './lib/page/join'
require './lib/page/deal'
require './lib/page/cards'
require './lib/main'

run Main.new(UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new))
