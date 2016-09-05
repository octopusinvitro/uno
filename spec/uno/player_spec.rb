describe "UNO::Player" do
  it "has a name" do
    expect(UNO::Player.new("Jane", []).name).to eq("Jane")
  end

  it "plays a card of the same number" do
    top_card = "3-red"
    cards    = ["5-blue", "3-green", "4-yellow"]
    expect(UNO::Player.new("", cards).play_turn(top_card)).to eq("3-green")
  end

  it "plays a card of the same color" do
    top_card = "1-red"
    cards    = ["5-blue", "3-green", "4-red"]
    expect(UNO::Player.new("", cards).play_turn(top_card)).to eq("4-red")
  end

  it "chooses number or color randomly" do
    top_card       = "3-red"
    cards          = ["5-blue", "3-green", "4-red", "wild"]
    playable_cards = ["3-green", "4-red"]
    expect(playable_cards).to include(UNO::Player.new("", cards).play_turn(top_card))
  end

  it "plays wild card if present and has no number or color" do
    top_card = "3-red"
    cards = ["wild", "5-blue", "4-yellow"]
    expect(UNO::Player.new("", cards).play_turn(top_card)).to eq("wild")
  end

  it "returns nothing if no cards and no wilds" do
    top_card = "3-red"
    cards = ["5-blue", "4-yellow"]
    expect(UNO::Player.new("", cards).play_turn(top_card)).to eq("")
  end

  it "removes the card from the players hand" do
    cards  = ["5-blue", "3-green", "4-yellow"]
    player = UNO::Player.new("", cards)
    player.play_turn("3-red")
    expect(player.cards).not_to include("3-green")
  end

  it "hand is intact if no card to play" do
    cards  = ["5-blue", "4-yellow"]
    player = UNO::Player.new("", cards)
    player.play_turn("3-red")
    expect(player.cards).to eq(cards)
  end

  it "can draw cards" do
    player = UNO::Player.new("", ["3-red"])
    player.draw(["5-blue", "4-yellow"])
    expect(player.cards).to eq(["3-red", "5-blue", "4-yellow"])
  end
end
