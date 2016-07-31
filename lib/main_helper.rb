class MainHelper

  def initialize(uno)
    @uno = uno
  end

  def response_for_join(params)
    valid?(params) ? join_success : join_failure
  end

  def response_for_deal
    deal? ? deal_success : deal_failure
  end

  def response_for_cards(params)
    params.has_key?("name") ? cards_success(params) : cards_failure
  end

  def max_players
    uno.max_players
  end

  private

  attr_reader :uno

  def valid?(params)
    params.has_key?("name") && !params["name"].empty? && join_game?(params["name"])
  end

  def join_game?(name)
    uno.join_game?(name)
  end

  def join_success
    {
      status:  Messages::JOIN_SUCCESS,
      joined:  true,
      players: uno.players
    }
  end

  def join_failure
    {
      status:  Messages::JOIN_FAILURE,
      joined:  false,
      players: uno.players
    }
  end

  def deal?
    uno.deal?
  end

  def deal_success
    {
      status:   Messages::DEAL_SUCCESS,
      dealt:    true,
      players:  uno.players,
      top_card: top_card
    }
  end

  def deal_failure
    {
      status:  Messages::DEAL_FAILURE,
      dealt:   false,
      players: uno.players,
      top_card: ""
    }
  end

  def top_card
    uno.flip_top_card
    uno.pool.first
  end

  def cards_success(params)
    cards = see_cards_of(params["name"])
    {
      cards:  cards,
      status: cards_status(cards)
    }
  end

  def cards_failure
    {}
  end

  def see_cards_of(name)
    uno.see_cards_of(name)
  end

  def cards_status(cards)
    cards.empty? ? Messages::CARDS_FAILURE : Messages::CARDS_SUCCESS
  end

  def parse(source, params = {})
    JSON.parse(source, params)
  end

end
