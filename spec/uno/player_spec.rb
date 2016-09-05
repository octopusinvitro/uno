describe "Player" do
  it "has a name" do
    expect(Player.new("Jane", []).name).to eq("Jane")
  end

  it "plays a card of the same number" do
    top_card = "3-red"
    cards    = ["5-blue", "3-green", "4-yellow"]
    expect(Player.new("", cards).play_turn(top_card)).to eq("3-green")
  end

  it "plays a card of the same color" do
    top_card = "1-red"
    cards    = ["5-blue", "3-green", "4-red"]
    expect(Player.new("", cards).play_turn(top_card)).to eq("4-red")
  end

  it "chooses number or color randomly" do
    top_card       = "3-red"
    cards          = ["5-blue", "3-green", "4-red", "wild"]
    playable_cards = ["3-green", "4-red"]
    expect(playable_cards).to include(Player.new("", cards).play_turn(top_card))
  end

  it "plays wild card if present and has no number or color" do
    top_card = "3-red"
    cards = ["wild", "5-blue", "4-yellow"]
    expect(Player.new("", cards).play_turn(top_card)).to eq("wild")
  end

  it "returns nothing if no cards and no wilds" do
    top_card = "3-red"
    cards = ["5-blue", "4-yellow"]
    expect(Player.new("", cards).play_turn(top_card)).to eq("")
  end
end
