class DeckTester
  attr_reader :deck
  def initialize
    @deck = Deck.buildDeck
  end
end

describe "Deck" do

  let(:deck) {DeckTester.new.deck}

  it "includes all reds" do
    expect_count_to_be(18 + 6 + 2, "red")
  end

  it "includes all yellows" do
    expect_count_to_be(26, "yellow")
  end

  it "includes all greens" do
    expect_count_to_be(26, "green")
  end

  it "includes all blues" do
    expect_count_to_be(26, "blue")
  end

  it "includes all skips" do
    expect_count_to_be(8, "skip")
  end

  it "includes all reverses" do
    expect_count_to_be(8, "reverse")
  end

  it "includes all draw2s" do
    expect_count_to_be(8, "draw2")
  end

  it "includes all zeros" do
    expect_count_to_be(4, "0-")
  end

  it "includes all draw4s" do
    expect_count_to_be(4, "draw4")
  end

  it "includes all wilds" do
    expect_count_to_be(4, "wild")
  end

  it "has a total of 108 cards" do
    expect(deck.length).to eq(108)
  end

  def expect_count_to_be(count, cards)
    expect(deck.join(" ").scan(cards).length).to eq(count)
  end

end
