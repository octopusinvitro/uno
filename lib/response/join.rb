# frozen_string_literal: true

module Response
  class Join
    def initialize(uno)
      @uno = uno
    end

    def response(params)
      valid?(params) ? success : failure
    end

    private

    attr_reader :uno

    def valid?(params)
      params.key?('name') &&
        !params['name'].empty? &&
        join_game?(params['name'])
    end

    def join_game?(name)
      uno.join_game?(name)
    end

    def success
      {
        status: Messages::JOIN_SUCCESS,
        joined: true,
        players: uno.players
      }
    end

    def failure
      {
        status: Messages::JOIN_FAILURE,
        joined: false,
        players: uno.players
      }
    end
  end
end
