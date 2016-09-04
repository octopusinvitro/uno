module Page
  class Cards
    def initialize(response:)
      @response = response
    end

    def title
      Messages::DEAL_TITLE
    end

    def cards_status
      response[:status]
    end

    def cards
      response[:cards]
    end

    private

    attr_reader :response
  end
end
