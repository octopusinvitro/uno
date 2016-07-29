describe "Main" do

  let(:uno) {UnoServer.new}
  let(:app) {Main.new(MainHelper.new(uno))}

  it "renders the error page if there is an error" do
    get "/unknown_path"
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include(Messages::NOT_FOUND)
  end

  it "renders the main page" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to include(Messages::MAIN_TITLE)
  end

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

      it "sends an error message if there are no players to deal cards to" do
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

      describe "" do
        let(:helper) {double(MainHelper)}
        let(:app)    {Main.new(helper)}

        it "renders the top card" do
          uno.join_game?("Jane")
          uno.join_game?("Joe")
          response = {deal_status: "foo", players: uno.players, top_card: "topcard"}
          allow(helper).to receive(:deal_response).and_return(response)
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

  describe "when asking for the cards of a player" do

    it "gets an existing player's cards" do
      uno.join_game?("Jane")
      uno.deal?
      get "/cards", "name" => "Jane"
      response = {
        cards:  uno.see_cards_of("Jane"),
        status: Messages::CARDS_SUCCESS
      }
      expect_response_to_eq(response)
    end

    it "sends an error message if player has not joined the game" do
      get "/cards", "name" => "Jane"
      response = {
        cards:  [],
        status: Messages::CARDS_FAILURE
      }
      expect_response_to_eq(response)
    end

    it "returns an empty response if no player is sent" do
      get "/cards"
      expect_response_to_eq({})
    end

  end


end
