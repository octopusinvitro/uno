class MainHelper

  def initialize(uno)
    @uno = uno
  end

  def response_for_cards(params)
    params.has_key?("name") ? cards_success(params) : cards_failure
  end

  private

  attr_reader :uno

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
