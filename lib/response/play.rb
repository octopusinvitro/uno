# frozen_string_literal: true

require_relative '../page/messages'

module Response
  class Play
    def initialize(uno, params = {})
      @uno = uno
      @params = params
    end

    def response
      valid? ? success : failure
    end

    private

    attr_reader :uno, :params

    def valid?
      params.slice('card', 'top_card').compact.size.positive?
    end

    def success
      play
      {
        status: Messages::PLAY_SUCCESS,
        dealt: true,
        top_card: top_card,
        hands: hands,
        cards: cards,
        finished: finished?
      }
    end

    def failure
      {
        status: Messages::PLAY_FAILURE,
        dealt: true,
        top_card: '',
        hands: [],
        cards: [],
        finished: false
      }
    end

    def play
      uno.human_play(uno.players.last, card, top_card)
    end

    def card
      return if params.slice('card').empty? || params['card'].empty?

      params['card']
    end

    def top_card
      card || params['top_card']
    end

    def hands
      uno.play(top_card)
    end

    def cards
      uno.players.last.cards
    end

    def finished?
      uno.players.last.finished?
    end
  end
end
