class MainHelper

  def initialize(uno)
    @uno = uno
  end

  def join_response(params)
    params.has_key?("data") ? build_join_response(params) : {}
  end

  def deal_response
    {status: deal_status}
  end

  def cards_response(params)
    params.has_key?("name") ? build_cards_response(params) : {}
  end

  private

  attr_reader :uno

  def build_join_response(params)
    data = parse(params["data"])
    {status: join_status(data)}
  end

  def build_cards_response(params)
    cards = see_cards_of(params["name"])
    {
      cards:  cards,
      status: cards_status(cards)
    }
  end

  def join_status(data)
    joined?(data) ? Messages::JOIN_SUCCESS : Messages::JOIN_FAILURE
  end

  def deal_status
    deal? ? Messages::DEAL_SUCCESS : Messages::DEAL_FAILURE
  end

  def cards_status(cards)
    cards.empty? ? Messages::CARDS_FAILURE : Messages::CARDS_SUCCESS
  end

  def joined?(data)
    data.has_key?("name") && join_game(data[:name])
  end

  def join_game(name)
    uno.join_game(name)
  end

  def deal?
    uno.deal
  end

  def see_cards_of(name)
    uno.see_cards_of(name)
  end

  def parse(source, params = {})
    JSON.parse(source, params)
  end

end
