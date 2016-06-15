# frozen_string_literal: true

require 'response/deal'
require 'uno/game'
require 'uno/player_factory'
require 'uno/server'

RSpec.describe Response::Deal do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:response) { described_class.new(uno).response }

  describe 'success' do
    before do
      uno.join('Jane')
      uno.join('Joe')
    end

    it 'has a successful status' do
      expect(response[:status]).to eq(Messages::DEAL_SUCCESS)
    end

    it 'has dealt' do
      expect(response[:dealt]).to be(true)
    end

    it 'has the hands' do
      expect(response[:hands].first[:name]).to eq('Jane')
    end

    it 'has the top card' do
      expect(response[:top_card]).not_to be_empty
    end

    it 'has the current players cards' do
      expect(response[:cards].size).to eq(UNO::Constants::MAX_CARDS)
    end
  end

  describe 'failure' do
    it 'can not deal if there are no players' do
      failure = {
        status: Messages::DEAL_FAILURE,
        dealt: false,
        hands: [],
        top_card: '',
        cards: []
      }
      expect(response).to eq(failure)
    end
  end
end
