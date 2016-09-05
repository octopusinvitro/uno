class Player
  attr_reader   :name
  attr_accessor :cards

  def initialize(name, cards)
    @name  = name
    @cards = cards
  end

  def play_turn(top_card)
    playable = select_playable(top_card)
    playable.empty? ? check_for_wild : choose_random(playable)
  end

  private

  def select_playable(top_card)
    cards.select { |card| same_number_or_color?(card, top_card) }
  end

  def same_number_or_color?(card, top_card)
    (card.include? top_card.split("-").first) ||
    (card.include? top_card.split("-").last)
  end

  def check_for_wild
    cards.find { |card| card == "wild" }.to_s
  end

  def choose_random(playable)
    playable[Random.rand(playable.size)]
  end
end
