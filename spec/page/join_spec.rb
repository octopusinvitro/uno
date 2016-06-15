# frozen_string_literal: true

require 'page/join'

RSpec.describe Page::Join do
  let(:response) do
    {
      status: 'A status',
      joined: true,
      name: 'Jane',
      can_join: true,
      players: %w[first last]
    }
  end
  let(:page) { described_class.new(response) }

  it 'has a title' do
    expect(page.title).not_to be_empty
  end

  it 'has a status' do
    expect(page.status).to eq('A status')
  end

  it 'has a name' do
    expect(page.name).to eq('Jane')
  end

  it 'has the players' do
    expect(page.players).to eq(%w[first last])
  end

  it 'marks the last player' do
    expect(page.you('last')).to eq(' (you)')
  end

  it 'does not mark the other players' do
    expect(page.you('first')).to be_empty
  end

  it 'knows if game is filled up' do
    expect(page.can_join?).to eq(true)
  end

  it 'has a button text' do
    expect(page.max_players_info).not_to be_empty
  end

  it 'has info on the maximum players' do
    expect(page.max_players_info).not_to be_empty
  end
end
