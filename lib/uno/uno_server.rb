class UnoServer

  attr_reader :deck, :pool, :players, :uno

  def initialize(uno)
    @deck = Deck.buildDeck
    @uno  = uno
    reset
  end

  def join_game? name
    player_joined = can_add_more?
    add(name) if player_joined
    player_joined
  end

  def deal?
    can_deal = has_players?
    deal_cards if can_deal
    can_deal
  end

  def see_cards_of name
    player = players.find { |player| player[:name] == name }
    return [] if player.nil?
    player[:cards].dup
  end

  def flip_top_card
    pool.unshift(pool.pop)
  end

  def top_card
    flip_top_card
    pool.first
  end

  def play_turn(cards, top_card)
    uno.play_turn(cards, top_card)
  end

  def reset
    @pool    = deck.dup
    @players = []
  end

  private

  def can_add_more?
    players.size < Constants::MAX_PLAYERS
  end

  def add(name)
    players.push({
      name:  name,
      cards: []
    })
  end

  def has_players?
    players.size > 0
  end

  def deal_cards
    @pool = pool.shuffle
    players.each { |player| player[:cards] = pool.pop(Constants::MAX_CARDS) }
  end
end
