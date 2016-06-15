class DeckTester
  include Deck
  def buildDeck
    Deck.buildDeck
  end
end

describe "Deck" do

  let(:deck_tester) {DeckTester.new}

  it "includes the jokers" do
    special_jokers = "joker joker"
    expect_deck_to_include(special_jokers)
  end

  it "includes all diamonds" do
    diamonds = "2-diamond 3-diamond 4-diamond 5-diamond 6-diamond 7-diamond 8-diamond 9-diamond 10-diamond"
    expect_deck_to_include(diamonds)
  end

  it "includes all hearts" do
    hearts = "2-heart 3-heart 4-heart 5-heart 6-heart 7-heart 8-heart 9-heart 10-heart"
    expect_deck_to_include(hearts)
  end

  it "includes all clubs" do
    clubs = "2-club 3-club 4-club 5-club 6-club 7-club 8-club 9-club 10-club"
    expect_deck_to_include(clubs)
  end

  it "includes all spades" do
    spades = "2-spade 3-spade 4-spade 5-spade 6-spade 7-spade 8-spade 9-spade 10-spade"
    expect_deck_to_include(spades)
  end

  it "includes all big diamonds" do
    special_diamonds = "king-diamond queen-diamond ace-diamond jack-diamond"
    expect_deck_to_include(special_diamonds)
  end

  it "includes all big hearts" do
    special_hearts = "king-heart queen-heart ace-heart jack-heart"
    expect_deck_to_include(special_hearts)
  end

  it "includes all big clubs" do
    special_clubs = "king-club queen-club ace-club jack-club"
    expect_deck_to_include(special_clubs)
  end

  it "includes all big spades" do
    special_spades = "king-spade queen-spade ace-spade jack-spade"
    expect_deck_to_include(special_spades)
  end

  it "has a total of 54 cards" do
    expect(deck_tester.buildDeck.length).to eq(54)
  end

  def expect_deck_to_include(this)
    expect(deck_tester.buildDeck.join(" ")).to include(this)
  end

end
