# frozen_string_literal: true

module Response
  class Cards
    def initialize(uno)
      @uno = uno
    end

    def response(params)
      params.key?('name') ? success(params) : failure
    end

    private

    attr_reader :uno

    def success(params)
      cards = see_cards_of(params['name'])
      {
        cards:  cards,
        status: status(cards)
      }
    end

    def failure
      {}
    end

    def see_cards_of(name)
      uno.see_cards_of(name)
    end

    def status(cards)
      cards.empty? ? Messages::CARDS_FAILURE : Messages::CARDS_SUCCESS
    end

    def parse(source, params = {})
      JSON.parse(source, params)
    end
  end
end
