describe "MainHelper" do

  let(:uno)    {UnoServer.new}
  let(:helper) {MainHelper.new(uno)}

  describe "when asking for the join response" do
    it "builds join message if params contains data" do
      params = {"data" => '{"name": "Jon"}'}
      expect(helper.join_response(params)).to eq({status: Messages::JOIN_SUCCESS})
    end

    it "returns an error message if there is no name in the data" do
      params = {"data" => '{}'}
      expect(helper.join_response(params)).to eq({status: Messages::JOIN_FAILURE})
    end

    it "returns an error message if the game is full" do
      fill_the_game
      params = {"data" => '{"name": "Jon"}'}
      expect(helper.join_response(params)).to eq({status: Messages::JOIN_FAILURE})
    end

    it "returns nothing if params contains no data" do
      params = {}
      expect(helper.join_response(params)).to eq({})
    end
  end

  describe "when asking for the deal response" do
    it "builds deal message if it there are players" do
      uno.join_game("Jon")
      expect(helper.deal_response).to eq({status: Messages::DEAL_SUCCESS})
    end

    it "returns an error message if there are no players" do
      expect(helper.deal_response).to eq({status: Messages::DEAL_FAILURE})
    end
  end

  describe "when asking for the cards response" do
    it "builds cards message if params contains a valid name" do
      uno.join_game("Jon")
      uno.deal
      params = {"name" => "Jon"}
      expect(helper.cards_response(params)[:cards]).to  eq(uno.see_cards_of("Jon"))
      expect(helper.cards_response(params)[:status]).to eq(Messages::CARDS_SUCCESS)
    end

    it "returns an error message if the player has no cards" do
      uno.join_game("Jon")
      params = {"name" => "Jon"}
      expect(helper.cards_response(params)[:cards]).to  eq(uno.see_cards_of("Jon"))
      expect(helper.cards_response(params)[:status]).to eq(Messages::CARDS_FAILURE)
    end

    it "returns an error message if the player is not in the game" do
      params = {"name" => "Jon"}
      expect(helper.cards_response(params)[:cards]).to  eq([])
      expect(helper.cards_response(params)[:status]).to eq(Messages::CARDS_FAILURE)
    end

    it "returns nothing if params contains no name" do
      params = {}
      expect(helper.cards_response(params)).to eq({})
    end
  end

end
