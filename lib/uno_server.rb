class UnoServer

  attr_reader :deck, :max_players, :max_cards, :pool, :players, :uno

  def initialize(uno)
    @deck        = Deck.buildDeck
    @max_players = 4
    @max_cards   = 7
    @uno         = uno
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

  def reset
    @pool    = deck.dup
    @players = []
  end

  def play_turn(player)
    uno.play_turn(player)
  end

  private

  def can_add_more?
    players.size < max_players
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
    players.each { |player| player[:cards] = pool.pop(max_cards) }
  end

end
