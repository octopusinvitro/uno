describe "Page::Deal" do
  let(:response) { {
    status:   Messages::DEAL_SUCCESS,
    dealt:    true,
    players:  [],
    top_card: "top card"
  } }
  let(:page) { Page::Deal.new(response: response) }

  it "has a title" do
    expect(page.title).to eq(Messages::DEAL_TITLE)
  end

  it "has a status" do
    expect(page.deal_status).to eq(Messages::DEAL_SUCCESS)
  end

  it "has a list of players" do
    expect(page.players).to eq([])
  end

  it "has a top card" do
    expect(page.top_card).to eq("top card")
  end
end
