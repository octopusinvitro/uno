# frozen_string_literal: true

module UNO
  class Player
    attr_reader   :name
    attr_accessor :cards

    def initialize(name, cards = [])
      @name  = name
      @cards = cards
    end

    def play_turn(top_card)
      card = select_card(top_card)
      play(card)
      card
    end

    def draw(group)
      @cards += group
    end

    private

    def select_card(top_card)
      playable_cards = select_playable(top_card)
      playable_cards.empty? ? check_for_wild : choose_random(playable_cards)
    end

    def select_playable(top_card)
      cards.select { |card| same_number_or_color?(card, top_card) }
    end

    def same_number_or_color?(card, top_card)
      (card.include? top_card.split('-').first) ||
        (card.include? top_card.split('-').last)
    end

    def check_for_wild
      cards.find { |card| card.include? 'wild' }.to_s
    end

    def choose_random(playable_cards)
      playable_cards[Random.rand(playable_cards.size)]
    end

    def play(card)
      @cards -= [card]
    end
  end
end
