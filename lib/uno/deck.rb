module UNO
  module Deck
    def self.buildDeck
      colors   = %w(red yellow green blue)
      specials = %w(skip reverse draw2)
      unique   = %w(0 draw4 wild)

      colors.map { |color|
        (
          all_cards(color) <<
          all_cards(color) <<
          all_specials(unique,   color) <<
          all_specials(specials, color) <<
          all_specials(specials, color)
        ).flatten
      }.flatten.freeze
    end

    def self.skip?(card)
      card.include? "skip"
    end

    def self.draw2?(card)
      card.include? "draw2"
    end

    def self.draw4?(card)
      card.include? "draw4"
    end

    def self.reverse?(card)
      card.include? "reverse"
    end

    private

    def self.all_cards(color)
      (1..9).map { |index| "#{index}-#{color}" }
    end

    def self.all_specials(specials, color)
      specials.map { |special| "#{special}-#{color}" }
    end
  end
end
