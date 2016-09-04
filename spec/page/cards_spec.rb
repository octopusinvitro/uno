describe "Page::Cards" do
  let(:response) { {
    cards:  [],
    status: Messages::CARDS_SUCCESS
    } }
  let(:page) { Page::Cards.new(response: response) }

  it "has a title" do
    expect(page.title).to eq(Messages::DEAL_TITLE)
  end

  it "knows its status" do
    expect(page.cards_status).to eq(Messages::CARDS_SUCCESS)
  end

  it "has the cards" do
    expect(page.cards).to eq([])
  end
end