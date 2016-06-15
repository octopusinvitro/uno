# frozen_string_literal: true

require_relative '../page/messages'

module Response
  class Join
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
      params.key?('name') && !params['name'].empty? && can_join?
    end

    def success
      join
      {
        status: Messages::JOIN_SUCCESS,
        joined: true,
        name: params['name'],
        can_join: can_join?,
        players: players
      }
    end

    def failure
      {
        status: Messages::JOIN_FAILURE,
        joined: false,
        name: params['name'],
        can_join: can_join?,
        players: players
      }
    end

    def can_join?
      uno.can_join?
    end

    def join
      uno.join(params['name'])
    end

    def players
      uno.players
    end
  end
end
