module Deck

  def self.buildDeck
    cards    = %w(red yellow green blue)
    specials = %w(skip reverse draw2)
    unique   = %w(0 draw4)

    %w(wild wild wild wild).concat( cards.map { |card|
      (all_cards(card) <<
       all_cards(card) <<
       all_specials(unique,   card) <<
       all_specials(specials, card) <<
       all_specials(specials, card) ).flatten
    }).flatten
  end

  private

  def self.all_cards(card)
    (1..9).map { |index| "#{index}-#{card}" }
  end

  def self.all_specials(specials, card)
    specials.map { |special| "#{special}-#{card}" }
  end

end
