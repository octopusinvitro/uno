# frozen_string_literal: true

require_relative '../page/messages'

module Response
  class Deal
    def initialize(uno)
      @uno = uno
    end

    def response
      valid? ? success : failure
    end

    private

    attr_reader :uno

    def valid?
      uno.can_deal?
    end

    def success
      deal
      {
        status: Messages::DEAL_SUCCESS,
        dealt: true,
        top_card: top_card,
        hands: hands,
        cards: cards
      }
    end

    def failure
      {
        status: Messages::DEAL_FAILURE,
        dealt: false,
        top_card: '',
        hands: [],
        cards: []
      }
    end

    def deal
      uno.deal
    end

    def top_card
      uno.top_card
    end

    def hands
      uno.play
    end

    def cards
      uno.players.last.cards
    end
  end
end
