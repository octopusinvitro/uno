# frozen_string_literal: true

require 'page/index'

RSpec.describe Page::Index do
  let(:page) { described_class.new('status') }

  it 'has a title' do
    expect(page.title).not_to be_empty
  end

  it 'has a status' do
    expect(page.status).to eq('status')
  end

  context 'if player joined' do
    it 'knows it' do
      expect(page.joined).to be(true)
    end

    it 'has a POST method' do
      expect(page.method).to eq('POST')
    end

    it 'has a join action' do
      expect(page.action).to eq('/join')
    end

    it 'shows the name input' do
      expect(page.class).not_to eq('hidden')
    end

    it 'has the button to join' do
      expect(page.button_text).to include('Join')
    end
  end

  context 'if player did not join' do
    let(:page) { described_class.new('status', joined: false) }

    it 'knows it' do
      expect(page.joined).to be(false)
    end

    it 'has a GET method' do
      expect(page.method).to eq('GET')
    end

    it 'has a deal action' do
      expect(page.action).to eq('/deal')
    end

    it 'hides the name input' do
      expect(page.class).to eq('hidden')
    end

    it 'has the button to play' do
      expect(page.button_text).to include('Start')
    end
  end
end
