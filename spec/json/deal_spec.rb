describe "Deal (JSON)" do
  let(:uno) {UnoServer.new(Uno.new)}
  let(:app) {Main.new(MainHelper.new(uno))}

  describe "when it's deal time" do
    before do
      header "Accept", "application/json"
    end

    it "deals cards to the players" do
      uno.join_game?("Jane")
      get "/deal"
      expect_to_have_dealt(true, Messages::DEAL_SUCCESS)
    end

    it "errors if there are no players" do
      get "/deal"
      expect_to_have_dealt(false, Messages::DEAL_FAILURE)
    end

    def expect_to_have_dealt(dealt, status)
      response = JSON.parse(last_response.body, symbolize_names: true)
      expect(last_response).to be_ok
      expect(response[:dealt]).to be(dealt)
      expect(response[:status]).to eq(status)
    end
  end
end
