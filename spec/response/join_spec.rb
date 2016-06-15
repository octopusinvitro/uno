# frozen_string_literal: true

require 'response/join'
require 'uno/game'
require 'uno/player_factory'
require 'uno/server'

RSpec.describe Response::Join do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }

  describe 'success' do
    let(:response) { described_class.new(uno, 'name' => 'May').response }

    it 'can join if a name was sent and player can join' do
      expect(response).to include(
        status: Messages::JOIN_SUCCESS, joined: true, name: 'May'
      )
    end

    it 'knows if it can add more players after this' do
      expect(response[:can_join]).to eq(true)
    end
  end

  describe 'failure' do
    it 'can not join if the game is full' do
      fill_the_game
      expect(described_class.new(uno, 'name' => 'May').response).to include(
        status: Messages::JOIN_FAILURE, joined: false, name: 'May'
      )
    end

    it 'knows if it can add more players after this' do
      fill_the_game
      response = described_class.new(uno, 'name' => 'May').response
      expect(response[:can_join]).to eq(false)
    end

    it 'can not join if the name is empty' do
      expect(described_class.new(uno, 'name' => '').response).to include(
        status: Messages::JOIN_FAILURE, joined: false, name: '', players: []
      )
    end

    it 'can not join if there is no name in the data' do
      expect(described_class.new(uno).response).to include(
        status: Messages::JOIN_FAILURE, joined: false, name: nil, players: []
      )
    end
  end
end
