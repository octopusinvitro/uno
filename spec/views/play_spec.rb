# frozen_string_literal: true

require 'nokogiri'

RSpec.describe 'Play View' do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:app) { Main.new(uno) }
  let(:page) { Nokogiri::HTML(last_response.body) }
  let(:card) { uno.players.last.cards.first }

  before do
    uno.join('Jane')
    uno.join('Joe')
  end

  describe 'when the player sends a card' do
    before do
      header 'Accept', 'text/html'
      get '/deal'
      header 'Accept', 'text/html'
      post '/play', 'card' => card
    end

    it 'renders the play view' do
      expect(last_response).to be_ok
    end

    it 'renders the right title' do
      expect(page.css('title').text).to eq(Messages::PLAY_TITLE)
    end

    it 'renders the right headings' do
      expect(page.css('.main h2').text).to eq(Messages::PLAY_TITLE)
    end

    it 'renders the play status message' do
      expect(page.css('.status').text).to include(Messages::PLAY_SUCCESS)
    end

    it 'renders a list of hands' do
      expect(page.css('.players-joined li').first.text).to include('Jane')
    end

    it "doesn't render the current player" do
      expect(page.css('.players-joined li').last.text).not_to include('Joe')
    end

    it 'renders the top card' do
      expect(page.css('.status + p').last.text).to include(card)
    end
  end

  describe 'when human has to skip turn' do
    before do
      header 'Accept', 'text/html'
      post '/play', 'card' => 'draw2'
    end

    it 'sends the top card' do
      expect(page.css('input[name="top_card"]')).not_to be_nil
    end
  end

  describe "when the game hasn't dealt" do
    before do
      header 'Accept', 'text/html'
      post '/play', 'card' => card
    end

    it 'errors' do
      expect(page.css('.status').text).to include(Messages::PLAY_FAILURE)
    end
  end

  describe 'when not acceptable MIME type' do
    it 'errors if no type' do
      get '/deal'
      expect(last_response.status).to eq(406)
    end

    it 'errors if bad type' do
      header 'Accept', 'text/xml'
      get '/deal'
      expect(last_response.status).to eq(406)
    end
  end
end
