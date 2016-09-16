module UNO
  class Game
    attr_reader :pool

    def initialize(deck = Deck.buildDeck)
      @deck = deck
      reset
    end

    def flip_top_card
      pool.unshift(pool.pop)
    end

    def top_card
      pool.first
    end

    def deal_cards(players)
      @pool = pool.shuffle
      players.each { |player| player.cards = pool.pop(Constants::MAX_CARDS) }
    end

    def play(players, top)
      players.map do |player|
        card = ""
        if skip?(top)
        elsif draw2?(top)
          draw(player, 2)
        elsif draw4?(top)
          draw(player, 4)
        else
          card = play_turn(player, top)
          top  = card
          pool.unshift(card)
        end
        {name: player.name, card: card}
      end
    end

    def reset
      @pool = deck.dup
    end

    private

    attr_reader :deck

    def skip?(top)
      Deck.skip?(top)
    end

    def draw2?(top)
      Deck.draw2?(top)
    end

    def draw4?(top)
      Deck.draw4?(top)
    end

    def draw(player, amount)
      player.draw(pool.pop(amount))
    end

    def play_turn(player, top)
      card = player.play_turn(top)
      if card.empty?
        draw(player, 1)
        card = player.play_turn(top)
      end
      card
    end
  end
end
