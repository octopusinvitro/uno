module Deck

  def self.buildDeck
    cards = %w(diamond heart club spade)
    bigs  = %w(king queen ace jack)

    %w(joker joker).concat( cards.map { |card|
      (all_cards(card) << all_bigs(bigs, card)).flatten
    }).flatten
  end

  private

  def self.all_cards(card)
    (2..10).map { |index| "#{index}-#{card}" }
  end

  def self.all_bigs(bigs, card)
    bigs.map { |big| "#{big}-#{card}" }
  end

end
