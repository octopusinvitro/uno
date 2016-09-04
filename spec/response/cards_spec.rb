describe "Response::Deal" do
  let(:uno)  { UnoServer.new(Uno.new) }
  let(:deal) { Response::Cards.new(uno) }

  it "returns nothing if params contains no name" do
    params = {}
    expect(deal.response(params)).to eq({})
  end

  it "builds cards message if params contains a valid name" do
    uno.join_game?("Jane")
    uno.deal?
    params = {"name" => "Jane"}
    expect(deal.response(params)[:cards]).to  eq(uno.see_cards_of("Jane"))
    expect(deal.response(params)[:status]).to eq(Messages::CARDS_SUCCESS)
  end

  it "returns an error message if the player has no cards" do
    uno.join_game?("Jane")
    params = {"name" => "Jane"}
    expect(deal.response(params)[:cards]).to  eq(uno.see_cards_of("Jane"))
    expect(deal.response(params)[:status]).to eq(Messages::CARDS_FAILURE)
  end

  it "returns an error message if the player is not in the game" do
    params = {"name" => "Jane"}
    expect(deal.response(params)[:cards]).to  eq([])
    expect(deal.response(params)[:status]).to eq(Messages::CARDS_FAILURE)
  end
end
