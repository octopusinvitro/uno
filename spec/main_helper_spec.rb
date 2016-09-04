describe "MainHelper" do
  let(:uno)    {UnoServer.new(Uno.new)}
  let(:helper) {MainHelper.new(uno)}

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
