# frozen_string_literal: true

require 'rest-client'

require 'uno/client'

RSpec.describe UNO::Client do
  let(:client) { double(RestClient) }
  let(:url) { 'http://localhost:8080' }
  let(:uno) { described_class.new(name: 'Jon', client: client, base_url: url) }

  describe 'when joining the game' do
    before do
      allow(client).to receive(:post).and_return(
        '{"response_key": "response_value"}'
      )
    end

    it 'sends a POST request with the right parameters' do
      params = {
        data: '{"name":"Jon"}',
        accept: :json
      }
      uno.join
      expect(client).to have_received(:post).once.with(url + '/join', params)
    end

    it 'returns the right response' do
      expect(uno.join).to eq(response_key: 'response_value')
    end
  end

  describe 'when getting the cards' do
    before do
      allow(client).to receive(:get).and_return(
        '{"response_key": "response_value"}'
      )
    end

    it 'sends a GET request with the right parameters' do
      params = { name: 'Jon' }
      uno.cards
      expect(client).to have_received(:get).once.with(
        url + '/cards', params: params
      )
    end

    it 'returns the right response' do
      expect(uno.cards).to eq('{"response_key": "response_value"}')
    end
  end

  describe 'when dealing the cards' do
    before do
      allow(client).to receive(:post).and_return(
        '{"response_key": "response_value"}'
      )
    end

    it 'sends a POST request with no data' do
      params = {
        data: '{}',
        accept: :json
      }
      uno.deal
      expect(client).to have_received(:post).once.with(url + '/deal', params)
    end

    it 'returns the right response' do
      expect(uno.deal).to eq('{"response_key": "response_value"}')
    end
  end
end
