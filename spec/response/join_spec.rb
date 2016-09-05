describe "Response::Join" do
  let(:uno)  { UnoServer.new(PlayerFactory.new) }
  let(:join) { Response::Join.new(uno) }

  it "builds join message if params contains a name" do
    params   = {"name" => "Jane"}
    response = {
      status: Messages::JOIN_SUCCESS,
      joined: true,
      players: uno.players
    }
    expect(join.response(params)).to eq(response)
  end

  it "returns an error message if the game is full" do
    fill_the_game
    params   = {"name" => "Jane"}
    response = {status: Messages::JOIN_FAILURE, joined: false, players: uno.players}
    expect(join.response(params)).to eq(response)
  end

  it "returns an error message if the name is empty" do
    params   = {"name" => ""}
    response = {status: Messages::JOIN_FAILURE, joined: false, players: []}
    expect(join.response(params)).to eq(response)
  end

  it "returns an error message if there is no name in the data" do
    params   = {}
    response = {status: Messages::JOIN_FAILURE, joined: false, players: []}
    expect(join.response(params)).to eq(response)
  end
end
