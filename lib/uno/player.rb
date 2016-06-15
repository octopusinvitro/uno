# frozen_string_literal: true

require_relative 'deck'

module UNO
  class Player
    attr_reader :name
    attr_accessor :cards

    def initialize(name, cards = [])
      @name = name
      @cards = cards
    end

    def play_turn(top_card)
      card = select_card(top_card)
      play(card)
    end

    def play(card)
      @cards.delete(card)
    end

    def draw(group)
      @cards += group
    end

    def finished?
      cards.empty?
    end

    private

    def select_card(top_card)
      playable_cards = same_number_or_color_than(top_card)
      playable_cards.empty? ? select_wild_card : playable_cards.sample
    end

    def same_number_or_color_than(top_card)
      Deck.find_with_same_number_or_color(cards, top_card)
    end

    def select_wild_card
      cards.find { |card| Deck.wild?(card) }
    end
  end
end
