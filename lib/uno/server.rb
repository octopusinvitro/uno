# frozen_string_literal: true

module UNO
  class Server
    attr_reader :players, :factory, :game

    def initialize(factory, game)
      @factory = factory
      @game = game
      reset
    end

    def join_game?(name)
      player_joined = can_add_more?
      add(name) if player_joined
      player_joined
    end

    def deal?
      can_deal = players?
      deal_cards if can_deal
      can_deal
    end

    def see_cards_of(name)
      selected_player = players.find { |player| player.name == name }
      return [] if selected_player.nil?

      selected_player.cards.dup
    end

    def top_card
      game.top_card
    end

    def reset
      game.reset
      @players = []
    end

    private

    def can_add_more?
      players.size < UNO::Constants::MAX_PLAYERS
    end

    def add(name)
      players.push(new_player(name))
    end

    def new_player(name)
      factory.player(name)
    end

    def players?
      !players.empty?
    end

    def deal_cards
      game.deal_cards(players)
    end
  end
end
