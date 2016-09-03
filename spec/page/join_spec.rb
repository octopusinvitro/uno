describe "Page::Join" do
  let(:response) { {
    status:  Messages::JOIN_SUCCESS,
    joined:  true,
    players: []
  } }
  let(:page) { Page::Join.new(response: response, params: {name: "Jane"}) }

  it "has a title" do
    expect(page.title).to eq(Messages::JOIN_TITLE)
  end

  it "has a status" do
    expect(page.join_status).to eq(Messages::JOIN_SUCCESS)
  end

  it "has a name" do
    expect(page.name).to eq("Jane")
  end

  it "has the players" do
    expect(page.players).to eq([])
  end

  it "has info on the maximum players" do
    expect(page.max_players_info).to eq(Messages::MAX_PLAYERS_INFO)
  end
end
