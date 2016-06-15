# frozen_string_literal: true

require 'uno/game'
require 'uno/player_factory'
require 'uno/server'

RSpec.describe UNO::Server do
  let(:uno) { described_class.new(UNO::PlayerFactory.new, UNO::Game.new) }

  it 'allows a player to join the game' do
    uno.join('Jane')
    expect(uno.players.size).to eq(1)
    expect(uno.players.first.name).to eq('Jane')
  end

  it 'does not allow a player to join if game is full' do
    uno.join('Jane')
    uno.join('Joe')
    uno.join('Moe')
    uno.join('May')
    uno.join('Will not join')
    expect(uno.players.map(&:name)).not_to include('Will not join')
  end

  it 'knows if a player can join the game' do
    expect(uno.can_join?).to eq(true)
  end

  it 'deals cards if there are players' do
    uno.join('Jane')
    uno.deal
    expect(uno.players.first.cards).not_to be_empty
  end

  it 'does not deal cards if there are no players' do
    game = instance_double(UNO::Game)
    allow(game).to receive(:reset)
    expect(game).not_to receive(:deal_cards)
    described_class.new('irrelevant', game).deal
  end

  it 'knows if it can deal cards' do
    uno.join('Jane')
    expect(uno.can_deal?).to eq(true)
  end

  it 'knows the top card' do
    expect(uno.top_card).to eq('1-red')
  end

  it 'plays a round with the game top card' do
    uno.join('Jane')
    uno.join('Joe')
    uno.deal
    hands = uno.play
    expect(hands.first[:name]).to eq('Jane')
  end

  it 'plays a round with another top card' do
    uno.join('Jane')
    uno.join('Joe')
    uno.deal
    hands = uno.play('7-yellow')
    expect(hands.first[:name]).to eq('Jane')
  end

  it 'does not play with the last player' do
    uno.join('Jane')
    uno.join('Joe')
    uno.deal
    hands = uno.play
    expect(hands.size).to eq(1)
  end

  it 'can play with a human' do
    human = UNO::Player.new('Human', %w[0-green 1-red])
    hands = uno.human_play(human, '1-red', '1-red')
    expect(hands).to eq(name: 'Human', card: '1-red')
  end

  it 'sees the cards of a player' do
    uno.join('Jane')
    uno.deal
    expect(uno.see_cards_of('Jane')).to eq(uno.players.first.cards)
  end

  it 'can not see cards of player if it finished playing' do
    uno.join('Jane')
    expect(uno.see_cards_of('Jane')).to be_empty
  end

  it 'can not see cards of inexisting player' do
    expect(uno.see_cards_of('Jane')).to be_empty
  end

  it 'resets the game' do
    uno.join('Jane')
    uno.deal
    uno.reset
    expect(uno.top_card).to eq('1-red')
    expect(uno.players).to be_empty
  end
end
