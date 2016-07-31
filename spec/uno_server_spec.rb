describe "UnoServer" do

  let(:uno)       {@uno}
  let(:max_cards) {uno.max_cards}

  before(:each) do
    @uno = UnoServer.new
  end

  it "starts with a deck of 108 cards" do
    expect(uno.deck.size).to eq(108)
  end

  it "allows a player to join the game" do
    uno.join_game?("Jane")
    expect(uno.players.size).to eq(1)
    expect(uno.players.first[:name]).to eq("Jane")
  end

  it "doesn't allow a player to join if there are four already" do
    expect(uno.join_game?("Jane")).to be(true)
    expect(uno.join_game?("Joe") ).to be(true)
    expect(uno.join_game?("Moe") ).to be(true)
    expect(uno.join_game?("May") ).to be(true)
    expect(uno.join_game?("Won't join")).to be(false)
  end

  it "doesn't deal cards if there are no players" do
    expect(uno.deal?).to be(false)
  end

  it "deals cards if there are players" do
    uno.join_game?("Jane")
    expect(uno.deal?).to be(true)
  end

  it "delivers the maximum cards to each player" do
    uno.join_game?("Jane")
    uno.deal?
    expect(uno.players.first[:cards].size).to eq(max_cards)
  end

  it "shuffles the cards" do
    uno.join_game?("Jane")
    uno.deal?
    expect(uno.players.first[:cards]).not_to eq(uno.deck[0...max_cards])
  end

  it "sees the cards of a player" do
    uno.join_game?("Jane")
    uno.deal?
    expect(uno.see_cards_of("Jane")).to eq(uno.players.first[:cards])
  end

  it "can't see the cards of non-existent player" do
    uno.join_game?("Jane")
    uno.deal?
    expect(uno.see_cards_of("Joe")).to eq([])
  end

  it "flips top card of the deck" do
    top_card = uno.pool.last
    uno.flip_top_card
    expect(uno.pool.first).to eq(top_card)
  end

  it "resets the game" do
    uno.join_game?("Jane")
    uno.deal?
    uno.reset
    expect(uno.pool).to eq(uno.deck)
    expect(uno.players).to eq([])
  end

  it "plays a player's turn" do
    uno.join_game?("Jane")
    uno.deal?
    jane = uno.players.first
    expect(jane[:cards]).to include(uno.play_turn(jane))
  end

end
