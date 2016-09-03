describe "MainHelper" do

  let(:uno)    {UnoServer.new(Uno.new)}
  let(:helper) {MainHelper.new(uno)}

  describe "when asking for the join response" do
    it "builds join message if params contains a name" do
      params   = {"name" => "Jane"}
      response = {status: Messages::JOIN_SUCCESS, joined: true, players: uno.players}
      expect(helper.response_for_join(params)).to eq(response)
    end

    it "returns an error message if the game is full" do
      fill_the_game
      params   = {"name" => "Jane"}
      response = {status: Messages::JOIN_FAILURE, joined: false, players: uno.players}
      expect(helper.response_for_join(params)).to eq(response)
    end

    it "returns an error message if the name is empty" do
      params   = {"name" => ""}
      response = {status: Messages::JOIN_FAILURE, joined: false, players: []}
      expect(helper.response_for_join(params)).to eq(response)
    end

    it "returns an error message if there is no name in the data" do
      params   = {}
      response = {status: Messages::JOIN_FAILURE, joined: false, players: []}
      expect(helper.response_for_join(params)).to eq(response)
    end
  end

  describe "when asking for the deal response" do
    it "returns an error message if there are no players" do
      expect(helper.response_for_deal[:status]).to eq(Messages::DEAL_FAILURE)
      expect(helper.response_for_deal[:dealt]).to be(false)
    end

    it "builds deal message if there are players" do
      uno.join_game?("Jane")
      expect(helper.response_for_deal[:status]).to eq(Messages::DEAL_SUCCESS)
      expect(helper.response_for_deal[:dealt]).to be(true)
    end
  end

  describe "when asking for the cards response" do
    it "returns nothing if params contains no name" do
      params = {}
      expect(helper.response_for_cards(params)).to eq({})
    end

    it "builds cards message if params contains a valid name" do
      uno.join_game?("Jane")
      uno.deal?
      params = {"name" => "Jane"}
      expect(helper.response_for_cards(params)[:cards]).to  eq(uno.see_cards_of("Jane"))
      expect(helper.response_for_cards(params)[:status]).to eq(Messages::CARDS_SUCCESS)
    end

    it "returns an error message if the player has no cards" do
      uno.join_game?("Jane")
      params = {"name" => "Jane"}
      expect(helper.response_for_cards(params)[:cards]).to  eq(uno.see_cards_of("Jane"))
      expect(helper.response_for_cards(params)[:status]).to eq(Messages::CARDS_FAILURE)
    end

    it "returns an error message if the player is not in the game" do
      params = {"name" => "Jane"}
      expect(helper.response_for_cards(params)[:cards]).to  eq([])
      expect(helper.response_for_cards(params)[:status]).to eq(Messages::CARDS_FAILURE)
    end
  end
end
