module Response
  class Join
    def initialize(uno)
      @uno = uno
    end

    def response(params)
      valid?(params) ? join_success : join_failure
    end

    private

    attr_reader :uno

    def valid?(params)
      params.has_key?("name") && !params["name"].empty? && join_game?(params["name"])
    end

    def join_game?(name)
      uno.join_game?(name)
    end

    def join_success
      {
        status:  Messages::JOIN_SUCCESS,
        joined:  true,
        players: uno.players
      }
    end

    def join_failure
      {
        status:  Messages::JOIN_FAILURE,
        joined:  false,
        players: uno.players
      }
    end
  end
end
