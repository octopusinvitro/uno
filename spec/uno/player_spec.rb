# frozen_string_literal: true

require 'uno/player'

RSpec.describe UNO::Player do
  let(:player) { described_class.new('Jane') }

  it 'has a name' do
    expect(player.name).to eq('Jane')
  end

  it 'plays a card of the same number' do
    player.cards = ['5-blue', '3-green', '4-yellow']
    expect(player.play_turn('3-red')).to eq('3-green')
  end

  it 'plays a card of the same color' do
    player.cards = ['5-blue', '3-green', '4-red']
    expect(player.play_turn('1-red')).to eq('4-red')
  end

  it 'chooses number or color randomly' do
    player.cards = ['5-blue', '3-green', '4-red', 'wild-blue']
    card = player.play_turn('3-red')
    expect(['3-green', '4-red']).to include(card)
  end

  it 'plays wild card if present and has no number or color' do
    player.cards = ['wild-green', '5-blue', '4-yellow']
    expect(player.play_turn('3-red')).to eq('wild-green')
  end

  it 'removes the played card from the players hand' do
    player.cards = ['5-blue', '3-green', '4-yellow']
    player.play_turn('3-red')
    expect(player.cards).not_to include('3-green')
  end

  it 'returns nothing if no cards and no wilds' do
    player.cards = ['5-blue', '4-yellow']
    expect(player.play_turn('3-red')).to be_nil
  end

  it 'can draw several cards' do
    player.cards = ['3-red']
    player.draw(['5-blue', '4-yellow'])
    expect(player.cards).to eq(['3-red', '5-blue', '4-yellow'])
  end

  it 'knows if it is finished' do
    player.cards = []
    expect(player.finished?).to eq(true)
  end

  it 'knows if it is not finished' do
    player.cards = ['0-red']
    expect(player.finished?).to eq(false)
  end
end
