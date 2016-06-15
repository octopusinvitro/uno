class UnoServer

  attr_reader :deck, :hands

  MAX_HANDS = 4
  MAX_CARDS = 5

  def initialize
    @deck  = Deck.buildDeck
    @hands = []
  end

  def join_game name
    player_joined = can_add_more?
    add(name) if player_joined
    player_joined
  end

  def deal
    can_deal = has_players?
    deal_cards if can_deal
    can_deal
  end

  def see_cards_of name
    player = hands.find { |player| player[:name] == name }
    return [] if player.nil?
    player[:cards].dup
  end

  private

  def can_add_more?
    hands.size < MAX_HANDS
  end

  def add(name)
    hands.push({
      name:  name,
      cards: []
    })
  end

  def has_players?
    hands.size > 0
  end

  def deal_cards
    hands.each { |player| player[:cards] = deck.shuffle.pop(MAX_CARDS) }
  end

end
