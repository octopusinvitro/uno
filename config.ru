# frozen_string_literal: true

require './lib/main'
require './lib/uno/game'
require './lib/uno/player_factory'
require './lib/uno/server'

run Main.new(UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new))
