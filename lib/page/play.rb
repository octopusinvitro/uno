# frozen_string_literal: true

require_relative 'messages'
require_relative '../uno/deck'

module Page
  class Play
    def initialize(response)
      @response = response
    end

    def title
      Messages::PLAY_TITLE
    end

    def status
      response[:status]
    end

    def dealt
      response[:dealt]
    end

    def top_card
      response[:top_card]
    end

    def hands
      @hands ||= response[:hands].map { |hand| new_hand_from(hand) }
    end

    def action_message
      return Messages::CHOOSE if choose?

      draw = " #{Messages::DRAW}" if draw?
      "#{Messages::SKIP}#{draw}"
    end

    def last_card
      @last_card ||= response[:hands].last&.fetch(:card)
    end

    def cards
      response[:cards]
    end

    def button_icon
      return Messages::CHOOSE_ICON if choose?

      return Messages::DRAW_ICON if draw?

      Messages::SKIP_ICON
    end

    def button_text
      return Messages::CHOOSE_BUTTON if choose?

      return Messages::DRAW_BUTTON if draw?

      Messages::SKIP_BUTTON
    end

    def choose?
      !skip?
    end

    def skip?
      UNO::Deck.skip?(last_card) || UNO::Deck.draw2?(last_card) ||
        UNO::Deck.draw4?(last_card)
    end

    private

    attr_reader :response

    def draw?
      UNO::Deck.draw2?(last_card) || UNO::Deck.draw4?(last_card)
    end

    def new_hand_from(hand)
      { name: hand[:name], card: hand[:card] || Messages::NO_CARD }
    end
  end
end
