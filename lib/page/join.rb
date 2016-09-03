module Page
  class Join
    def initialize(response:, params:)
      @response = response
      @params   = params
    end

    def title
      Messages::JOIN_TITLE
    end

    def join_status
      response[:status]
    end

    def name
      params[:name]
    end

    def players
      response[:players]
    end

    def max_players_info
      Messages::MAX_PLAYERS_INFO
    end

    private

    attr_reader :response, :params
  end
end
