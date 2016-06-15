# frozen_string_literal: true

require 'response/play'
require 'uno/game'
require 'uno/player_factory'
require 'uno/server'

RSpec.describe Response::Play do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }

  before do
    uno.join('Jane')
    uno.join('Joe')
    uno.deal
  end

  describe 'success' do
    let(:card) { uno.players.last.cards.first }
    let(:response) { described_class.new(uno, 'card' => card).response }

    it 'has a successful status' do
      expect(response[:status]).to eq(Messages::PLAY_SUCCESS)
    end

    it 'has dealt' do
      expect(response[:dealt]).to be(true)
    end

    it 'has the top card' do
      expect(response[:top_card]).to eq(card)
    end

    it 'has the hands' do
      expect(response[:hands].first[:name]).to eq('Jane')
    end

    it "has the current player's cards" do
      hand_without_played_card = UNO::Constants::MAX_CARDS - 1
      expect(response[:cards].size).to eq(hand_without_played_card)
    end

    it 'has removed card from player hand' do
      expect(response[:cards]).not_to include(card)
    end

    it 'is not finished with the human' do
      expect(response[:finished]).to eq(false)
    end
  end

  describe 'when player skipped the turn' do
    let(:response) do
      described_class.new(uno, 'top_card' => 'skip-red').response
    end

    before do
      uno.join('Jane')
      uno.join('Joe')
      uno.deal
    end

    it 'has a successful status' do
      expect(response[:status]).to eq(Messages::PLAY_SUCCESS)
    end

    it 'has dealt' do
      expect(response[:dealt]).to be(true)
    end

    it 'has the top card' do
      expect(response[:top_card]).to eq('skip-red')
    end

    it 'has the hands' do
      expect(response[:hands].first[:name]).to eq('Jane')
    end

    it 'does not remove cards from the player' do
      expect(response[:cards].size).to eq(UNO::Constants::MAX_CARDS)
    end
  end

  describe 'failure' do
    let(:failure) do
      {
        status: Messages::PLAY_FAILURE,
        dealt: true,
        top_card: '',
        hands: [],
        cards: [],
        finished: false
      }
    end

    it 'fails if no card and no top card is sent' do
      expect(described_class.new(uno).response).to eq(failure)
    end
  end

  describe 'player finished' do
    it 'knows that it finished' do
      uno.join('Finished')
      uno.players.last.cards = ['2-red']
      response = described_class.new(uno, 'card' => '2-red').response
      expect(response[:finished]).to eq(true)
    end
  end
end
