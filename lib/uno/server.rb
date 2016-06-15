# frozen_string_literal: true

require_relative 'constants'

module UNO
  class Server
    attr_reader :players, :factory, :game

    def initialize(factory, game)
      @factory = factory
      @game = game
      reset
    end

    def reset
      game.reset
      @players = []
    end

    def join(name)
      players << factory.player(name) if can_join?
    end

    def can_join?
      players.size < Constants::MAX_PLAYERS
    end

    def deal
      game.deal_cards(players) if can_deal?
    end

    def can_deal?
      !players.empty?
    end

    def top_card
      game.top_card
    end

    def play(top = top_card)
      game.play(players_without_the_last, top)
    end

    def human_play(player, card, top)
      game.human_play(player, card, top)
    end

    def see_cards_of(name)
      selected_player = players.find { |player| player.name == name }
      return [] unless selected_player

      selected_player.cards.dup
    end

    private

    def players_without_the_last
      players[0..-2]
    end
  end
end
