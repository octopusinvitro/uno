class Uno
  def play_turn(cards, top_card)
    playable = select_playable(cards, top_card)
    playable.empty? ? check_for_wild(cards) : choose_random(playable)
  end

  private

  def select_playable(cards, top_card)
    cards.select { |card| same_number_or_color?(card, top_card) }
  end

  def same_number_or_color?(card, top_card)
    (card.include? top_card.split("-").first) ||
    (card.include? top_card.split("-").last)
  end

  def check_for_wild(cards)
    cards.select { |card| card == "wild" }.first.to_s
  end

  def choose_random(playable)
    playable[Random.rand(playable.size)]
  end
end
