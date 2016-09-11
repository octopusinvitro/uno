module UNO
  module Deck
    def self.buildDeck
      colors   = %w(red yellow green blue)
      specials = %w(skip reverse draw2)
      unique   = %w(0 draw4)

      %w(wild wild wild wild).concat( colors.map { |color|
        (
          all_cards(color) <<
          all_cards(color) <<
          all_specials(unique,   color) <<
          all_specials(specials, color) <<
          all_specials(specials, color)
        ).flatten
      }.flatten.freeze
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
