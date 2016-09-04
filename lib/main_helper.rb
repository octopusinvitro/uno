class MainHelper

  def initialize(uno)
    @uno = uno
  end

  def response_for_deal
    deal? ? deal_success : deal_failure
  end

  def response_for_cards(params)
    params.has_key?("name") ? cards_success(params) : cards_failure
  end

  private

  attr_reader :uno

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
