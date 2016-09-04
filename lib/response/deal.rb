module Response
  class Deal
    def initialize(uno)
      @uno = uno
    end

    def response
      deal? ? deal_success : deal_failure
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
        players:  players,
        top_card: top_card
      }
    end

    def deal_failure
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
