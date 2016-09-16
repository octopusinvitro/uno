describe "Response::Deal" do
  let(:uno)  { UNO::Server.new(UNO::PlayerFactory.new, UNO::Game.new) }
  let(:deal) { Response::Deal.new(uno) }

  it "fails if there are no players" do
    response = {
      status:   Messages::DEAL_FAILURE,
      dealt:    false,
      players:  [],
      top_card: ""
    }
    expect(deal.response).to eq(response)
  end

  describe "when the deal is successful" do
    before { uno.join_game?("Jane") }

    it "has a successful status" do
      expect(deal.response[:status]).to eq(Messages::DEAL_SUCCESS)
    end

    it "has dealt" do
      expect(deal.response[:dealt]).to be(true)
    end

    it "has the players" do
      expect(deal.response[:players]).to be(uno.players)
    end

    it "has the top card" do
      top_card = deal.response[:top_card]
      expect(uno.pool.first).to eq(top_card)
    end
  end
end
