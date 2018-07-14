# frozen_string_literal: true

module UNO
  module Deck
    COLORS   = %w[red yellow green blue].freeze
    SPECIALS = %w[skip reverse draw2].freeze
    UNIQUE   = %w[0 draw4 wild].freeze

    def self.build_deck
      COLORS.map do |color|
        (
          all_cards(color) <<
            all_cards(color) <<
            all_specials(UNIQUE,   color) <<
            all_specials(SPECIALS, color) <<
            all_specials(SPECIALS, color)
        ).flatten
      end.flatten.freeze
    end

    def self.all_cards(color)
      (1..9).map { |index| "#{index}-#{color}" }
    end

    def self.all_specials(specials, color)
      specials.map { |special| "#{special}-#{color}" }
    end

    def self.skip?(card)
      card.include? 'skip'
    end

    def self.draw2?(card)
      card.include? 'draw2'
    end

    def self.draw4?(card)
      card.include? 'draw4'
    end

    def self.reverse?(card)
      card.include? 'reverse'
    end
  end
end
