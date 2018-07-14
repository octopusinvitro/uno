# frozen_string_literal: true

RSpec.describe 'UNO::Server' do
  let(:server)    { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:max_cards) { UNO::Constants::MAX_CARDS }

  it 'allows a player to join the game' do
    server.join_game?('Jane')
    expect(server.players.size).to eq(1)
    expect(server.players.first.name).to eq('Jane')
  end

  it "doesn't allow a player to join if there are four already" do
    expect(server.join_game?('Jane')).to be(true)
    expect(server.join_game?('Joe')).to be(true)
    expect(server.join_game?('Moe')).to be(true)
    expect(server.join_game?('May')).to be(true)
    expect(server.join_game?("Won't join")).to be(false)
  end

  it "doesn't deal cards if there are no players" do
    expect(server.deal?).to be(false)
  end

  it 'deals cards if there are players' do
    server.join_game?('Jane')
    expect(server.deal?).to be(true)
  end

  it 'delivers the maximum cards to each player' do
    server.join_game?('Jane')
    server.deal?
    expect(server.players.first.cards.size).to eq(max_cards)
  end

  it 'sees the cards of a player' do
    server.join_game?('Jane')
    server.deal?
    expect(server.see_cards_of('Jane')).to eq(server.players.first.cards)
  end

  it "can't see the cards of non-existent player" do
    server.join_game?('Jane')
    server.deal?
    expect(server.see_cards_of('Joe')).to eq([])
  end

  it 'shows the top card' do
    expect(server.top_card).to eq('1-red')
  end

  it 'resets the game' do
    server.join_game?('Jane')
    server.deal?
    server.reset
    expect(server.top_card).to eq('1-red')
    expect(server.players).to eq([])
  end
end
