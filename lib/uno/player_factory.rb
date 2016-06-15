# frozen_string_literal: true

require_relative 'player'

module UNO
  class PlayerFactory
    def player(name, cards = [])
      Player.new(name, cards)
    end
  end
end
