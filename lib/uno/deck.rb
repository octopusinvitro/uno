# frozen_string_literal: true

module UNO
  module Deck
    COLORS = %w[red yellow green blue].freeze
    SEPARATOR = '-'
    SPECIALS = %w[skip reverse draw2].freeze
    UNIQUE = %w[0 draw4 wild].freeze

    def self.build_deck
      grouped_by_color = COLORS.map do |color|
        all_cards(color) +
          all_cards(color) +
          all_specials(SPECIALS, color) +
          all_specials(SPECIALS, color) +
          all_specials(UNIQUE, color)
      end
      grouped_by_color.flatten.freeze
    end

    def self.skip?(card)
      card.to_s.include?('skip')
    end

    def self.draw2?(card)
      card.to_s.include?('draw2')
    end

    def self.draw4?(card)
      card.to_s.include?('draw4')
    end

    def self.wild?(card)
      card.to_s.include?('wild')
    end

    def self.reverse?(card)
      card.to_s.include?('reverse')
    end

    def self.find_with_same_number_or_color(cards, number_and_color)
      pair = number_and_color.split(SEPARATOR)

      cards.select do |card|
        card.to_s.include?(pair.first) || card.to_s.include?(pair.last)
      end
    end

    def self.all_cards(color)
      (1..9).map { |index| "#{index}-#{color}" }
    end

    def self.all_specials(specials, color)
      specials.map { |special| "#{special}-#{color}" }
    end
  end
end
