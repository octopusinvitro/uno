class Uno
  def play_turn(cards, top_card)
    playable = select_playable(cards, top_card)
    if playable.empty?
      has_wild?(cards) ? "wild" : ""
    else
      playable[Random.rand(playable.size)]
    end
  end

  private

  def select_playable(cards, top_card)
    cards.select { |card| same_number_or_color?(card, top_card) }
  end

  def same_number_or_color?(card, top_card)
    (card.include? top_card.split("-").first) ||
    (card.include? top_card.split("-").last)
  end

  def has_wild?(cards)
    cards.include? "wild"
  end
end
