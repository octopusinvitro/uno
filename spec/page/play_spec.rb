# frozen_string_literal: true

require 'page/play'

RSpec.describe Page::Play do
  let(:response) do
    {
      status: 'A status',
      dealt: true,
      top_card: 'top card',
      hands: [{ name: 'foo', card: nil }],
      cards: %w[foo bar]
    }
  end
  let(:page) { described_class.new(response) }

  it 'has a title' do
    expect(page.title).not_to be_empty
  end

  it 'has a status' do
    expect(page.status).to eq('A status')
  end

  it 'knows if it has dealt' do
    expect(page.dealt).to be(true)
  end

  it 'has a top card' do
    expect(page.top_card).to eq('top card')
  end

  it 'has a list of hands' do
    expect(page.hands.first[:name]).to eq('foo')
  end

  it 'marks skipped turns in the list of hands' do
    expect(page.hands.first[:card]).not_to be_nil
  end

  it 'knows if current player must choose a card' do
    expect(page.action_message).to include(Messages::CHOOSE)
  end

  it 'knows if current player must skip a turn' do
    response[:hands] = [{ name: 'foo', card: 'skip' }]
    expect(page.action_message).to include(Messages::SKIP)
  end

  it 'knows if current player must draw cards' do
    response[:hands] = [{ name: 'foo', card: 'draw2' }]
    expect(page.action_message).to include(Messages::DRAW)
  end

  it 'knows if current player does not skip a turn' do
    expect(page.skip?).to eq(false)
  end

  xit 'knows if current player does not skip a turn' do
    expect(page.draw?).to eq(false)
  end

  it "knows the last non-human player's card" do
    expect(page.last_card).to eq(nil)
  end

  it "knows the human player's cards" do
    expect(page.cards).to eq(%w[foo bar])
  end

  it 'has the form button text when choosing' do
    expect(page.button_text).to eq(Messages::CHOOSE_BUTTON)
  end

  it 'has the form button text when skipping' do
    response[:hands] = [{ name: 'foo', card: 'skip' }]
    expect(page.button_text).to include(Messages::SKIP_BUTTON)
  end

  it 'has the form button text when drawing' do
    response[:hands] = [{ name: 'foo', card: 'draw2' }]
    expect(page.button_text).to include(Messages::DRAW_BUTTON)
  end
end
