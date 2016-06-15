# frozen_string_literal: true

require_relative 'messages'

module Page
  class Join
    def initialize(response)
      @response = response
    end

    def title
      Messages::JOIN_TITLE
    end

    def status
      response[:status]
    end

    def name
      response[:name]
    end

    def players
      response[:players]
    end

    def you(player)
      player == players.last ? ' (you)' : ''
    end

    def can_join?
      response[:can_join]
    end

    def button_text
      Messages::PLAY_BUTTON
    end

    def max_players_info
      can_join? ? Messages::MAX_PLAYERS_INFO : Messages::GAME_IS_FULL
    end

    private

    attr_reader :response
  end
end
