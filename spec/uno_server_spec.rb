describe "UnoServer" do

  let(:uno)       {@uno}
  let(:max_cards) {UnoServer::MAX_CARDS}

  before(:each) do
    @uno = UnoServer.new
  end

  it "starts with a deck of 54 cards" do
    expect(uno.deck.size).to eq(54)
  end

  it "allows a player to join the game" do
    uno.join_game("Jane")
    expect(uno.hands.size).to eq(1)
    expect(uno.hands[0][:name]).to eq("Jane")
  end

  it "doesn't allow a player to join if there are four already" do
    uno.join_game("Jane")
    uno.join_game("Joe")
    uno.join_game("Moe")
    expect(uno.join_game("May")).to be(true)
    expect(uno.join_game("Won't join")).to be(false)
  end

  it "doesn't deal cards if there are no players" do
    expect(uno.deal).to be(false)
  end

  it "deals cards if there are players" do
    uno.join_game("Jane")
    uno.deal
    expect(uno.deal).to be(true)
  end

  it "delivers the maximum cards to each player" do
    uno.join_game("Jane")
    uno.join_game("Joe")
    uno.deal
    expect(uno.hands.first[:cards].size).to eq(max_cards)
    expect(uno.hands.last[:cards].size).to eq(max_cards)
  end

  it "shuffles the cards" do
    uno.join_game("Jane")
    uno.deal
    expect(uno.hands.first[:cards]).not_to eq(uno.deck[0...max_cards])
  end

  it "sees the cards of a player" do
    uno.join_game("Jane")
    uno.deal
    expect(uno.see_cards_of("Jane")).to eq(uno.hands.first[:cards])
  end

  it "can't see the cards of non-existent player" do
    uno.join_game("Jane")
    uno.deal
    expect(uno.see_cards_of("Joe")).to eq([])
  end

end
