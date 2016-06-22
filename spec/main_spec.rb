describe "Main" do

  let(:uno)    {UnoServer.new}
  let(:app)    {Main.new(MainHelper.new(uno))}

  describe "when a player joins the game" do

    it "welcomes the player" do
      post "/join", "data" => '{"name": "Jon"}'
      response = {status: Messages::JOIN_SUCCESS}
      expect_response_to_eq(response)
    end

    it "sends an error message if no name is sent" do
      post "/join", "data" => '{}'
      response = {status: Messages::JOIN_FAILURE}
      expect_response_to_eq(response)
    end

    it "sends an error message if player could not join the game" do
      fill_the_game
      post "/join", "data" => '{"name": "Jon"}'
      response = {status: Messages::JOIN_FAILURE}
      expect_response_to_eq(response)
    end

    it "returns an empty response if no data is sent" do
      post "/join"
      expect_response_to_eq({})
    end

  end

  describe "when it's deal time" do

    it "deals cards to the players" do
      uno.join_game("Jon")
      post "/deal"
      response = {status: Messages::DEAL_SUCCESS}
      expect_response_to_eq(response)
    end

    it "sends an error message if there are no players to deal to" do
      post "/deal"
      response = {status: Messages::DEAL_FAILURE}
      expect_response_to_eq(response)
    end

  end

  describe "when asking for the cards of a player" do

    it "gets an existing player's cards" do
      uno.join_game("Jon")
      uno.deal
      get "/cards", "name" => "Jon"
      response = {
        cards:  uno.see_cards_of("Jon"),
        status: Messages::CARDS_SUCCESS
      }
      expect_response_to_eq(response)
    end

    it "sends an error message if player has not joined the game" do
      get "/cards", "name" => "Jon"
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

  def expect_response_to_eq(response)
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body, symbolize_names: true)).to eq(response)
  end

end
