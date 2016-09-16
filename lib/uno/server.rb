module UNO
  class Server

    attr_reader :deck, :pool, :players, :factory

    def initialize(factory, game)
      @factory = factory
      reset
    end

    def join_game? name
      player_joined = can_add_more?
      add(name) if player_joined
      player_joined
    end

    def deal?
      can_deal = has_players?
      deal_cards if can_deal
      can_deal
    end

    def see_cards_of name
      player = players.find { |player| player.name == name }
      return [] if player.nil?
      player.cards.dup
    end

    def flip_top_card
      pool.unshift(pool.pop)
    end

    def top_card
      flip_top_card
      pool.first
    end

    def reset
      @pool    = deck.dup
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

    def has_players?
      players.size > 0
    end

    def deal_cards
      @pool = pool.shuffle
      players.each { |player| player.cards = pool.pop(Constants::MAX_CARDS) }
    end
  end
end
