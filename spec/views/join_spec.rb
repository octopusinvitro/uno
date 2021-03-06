# frozen_string_literal: true

require 'nokogiri'

RSpec.describe 'Join View' do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:app) { Main.new(uno) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe 'when loading is successful' do
    before do
      header 'Accept', 'text/html'
      post '/join', 'name' => 'Jane'
    end

    it 'renders the join view' do
      expect(last_response).to be_ok
    end

    it 'renders the right title' do
      expect(page.css('title').text).to eq(Messages::JOIN_TITLE)
    end

    it 'renders the right headings' do
      expect(page.css('.main h2').text).to eq(Messages::JOIN_TITLE)
    end

    it "renders the player's name" do
      expect(page.css('.status').text).to include('Jane')
    end

    it 'renders the join status message' do
      expect(page.css('.status').text).to include(Messages::JOIN_SUCCESS)
    end

    it 'renders the maximum players info' do
      expect(page.css('.status').text).to include(Messages::MAX_PLAYERS_INFO)
    end

    it 'renders a list of players' do
      post '/join', 'name' => 'Joe'
      expect(page.css('.players-joined li').first.text).to include('Jane')
      expect(page.css('.players-joined li').last.text).to include('Joe (you)')
    end

    it 'hides the link to add more players if game is filled' do
      fill_the_game
      header 'Accept', 'text/html'
      post '/join', 'name' => 'Jane'
      expect(page.css('body').text).not_to include('Add another player')
    end
  end

  describe 'when no name is sent' do
    before do
      header 'Accept', 'text/html'
      post '/join', 'name' => ''
    end

    it 'renders the index view' do
      expect(page.css('title').text).to eq(Messages::MAIN_TITLE)
    end

    it 'displays an error status' do
      expect(page.css('body').text).to include(Messages::JOIN_FAILURE)
    end

    it 'hides name input' do
      expect(page.at_css('div.hidden')).not_to be_nil
    end

    it 'allows to try again' do
      expect(page.at_css('body').text).to include('Try again')
    end
  end

  describe 'when game is full' do
    before do
      fill_the_game
      header 'Accept', 'text/html'
      post '/join', 'name' => 'Jane'
    end

    it 'renders the index view' do
      expect(page.css('title').text).to eq(Messages::MAIN_TITLE)
    end

    it 'displays an error status' do
      expect(page.css('body').text).to include(Messages::JOIN_FAILURE)
    end
  end

  describe 'when not acceptable MIME type' do
    it 'errors' do
      post '/join', 'name' => 'Jane'
      expect(last_response.status).to eq(406)
    end
  end
end
