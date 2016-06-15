# frozen_string_literal: true

require 'nokogiri'

RSpec.describe 'Deal View' do
  let(:uno) { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:app) { Main.new(uno) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe 'when there are players' do
    before do
      uno.join('Jane')
      uno.join('Joe')
      header 'Accept', 'text/html'
      get '/deal'
    end

    it 'renders the deal view' do
      expect(last_response).to be_ok
    end

    it 'renders the right title' do
      expect(page.css('title').text).to eq(Messages::PLAY_TITLE)
    end

    it 'renders the right headings' do
      expect(page.css('.main h2').text).to eq(Messages::PLAY_TITLE)
    end

    it 'renders the deal status message' do
      expect(page.css('.status').text).to include(Messages::DEAL_SUCCESS)
    end

    it 'renders the top card' do
      expect(page.css('.status + p').last.text).not_to be_nil
    end

    it 'renders a list of hands' do
      expect(page.css('.players-joined li').first.text).to include('Jane')
    end

    it "doesn't render the current player" do
      expect(page.css('.players-joined li').last.text).not_to include('Joe')
    end

    it 'show action message' do
      expect(page.at_css('.players-joined + p')).not_to be_nil
    end
  end

  describe 'when there are no players' do
    before do
      header 'Accept', 'text/html'
      get '/deal'
    end

    it 'shows an error' do
      expect(last_response.status).to eq(200)
      expect(page.css('.status').text).to include(Messages::DEAL_FAILURE)
    end

    it 'does not show contents other than status' do
      expect(page.css('.players-joined')).to be_empty
      expect(page.css('form')).to be_empty
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
