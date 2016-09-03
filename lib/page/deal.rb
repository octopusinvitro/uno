module Page
  class Deal
    def initialize(response:)
      @response = response
    end

    def title
      Messages::DEAL_TITLE
    end

    def deal_status
      response[:status]
    end

    def players
      response[:players]
    end

    def top_card
      response[:top_card]
    end

    private

    attr_reader :response
  end
end
