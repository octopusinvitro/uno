describe "Main" do

  let(:uno) {UnoServer.new(Uno.new)}
  let(:app) {Main.new(MainHelper.new(uno))}

  describe "when it's deal time" do
    describe "(JSON)" do
      before(:each) do
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
    end

    describe "(views)" do
      before(:each) do
        header "Accept", "text/html"
      end

      it "renders the deal page if there are players" do
        uno.join_game?("Jane")
        get "/deal"
        expect_body_to_include(Messages::DEAL_TITLE, Messages::DEAL_SUCCESS)
      end

      it "renders the players" do
        uno.join_game?("Jane")
        uno.join_game?("Joe")
        get "/deal"
        expect(last_response.body).to include("Jane")
      end

      it "doesn't render the current player" do
        uno.join_game?("Jane")
        uno.join_game?("Joe")
        get "/deal"
        expect(last_response.body).not_to include("Joe")
      end

      it "errors if there are no players" do
        get "/deal"
        expect(last_response.status).to eq(500)
      end

      describe "when done" do
        let(:helper) {double(MainHelper)}
        let(:app)    {Main.new(helper)}

        it "renders the top card" do
          uno.join_game?("Jane")
          uno.join_game?("Joe")
          response = {deal_status: "irrelevant", players: uno.players, top_card: "topcard"}
          allow(helper).to receive(:response_for_deal).and_return(response)
          get "/deal"
          expect(last_response.body).to include(response[:top_card])
        end
      end

      it "renders the players cards" do
        uno.join_game?("Jane")
        get "/deal"
        expect(last_response.body).to include(uno.players.first[:cards].first)
      end
    end
  end
end
