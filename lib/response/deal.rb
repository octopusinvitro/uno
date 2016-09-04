module Response
  class Deal
    def initialize(uno)
      @uno = uno
    end

    def response
      deal? ? success : failure
    end

    private

    attr_reader :uno

    def deal?
      uno.deal?
    end

    def success
      {
        status:   Messages::DEAL_SUCCESS,
        dealt:    true,
        players:  players,
        top_card: top_card
      }
    end

    def failure
      {
        status:   Messages::DEAL_FAILURE,
        dealt:    false,
        players:  players,
        top_card: ""
      }
    end

    def players
      uno.players
    end

    def top_card
      uno.top_card
    end
  end
end
