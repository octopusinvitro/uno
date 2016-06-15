# frozen_string_literal: true

require 'json'
require 'rest-client'

module UNO
  class Client
    def initialize(options = {})
      @name = options.fetch(:name, 'No name')
      @client = options.fetch(:client, RestClient)
      @base_url = options.fetch(:base_url, 'http://localhost:4567')
    end

    def join
      response = post(base_url + '/join', post_params(name: name))
      parse(response, symbolize_names: true)
    end

    def cards
      get(base_url + '/cards', get_params(name: name))
    end

    def deal
      post(base_url + '/deal', post_params({}))
    end

    private

    attr_reader :name, :client, :base_url

    def post(url, params)
      client.post(url, params)
    end

    def get(url, params)
      client.get(url, params)
    end

    def parse(source, params)
      JSON.parse(source, params)
    end

    def post_params(data)
      {
        data: data.to_json,
        accept: :json
      }
    end

    def get_params(data)
      {
        params: data
      }
    end
  end
end
