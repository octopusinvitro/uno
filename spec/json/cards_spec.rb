describe "Cards (JSON)" do
  let(:uno) {UnoServer.new(Uno.new)}
  let(:app) {Main.new(MainHelper.new(uno))}

  describe "when asking for the cards of a player" do
    before do
      uno.join_game?("Jane")
      uno.join_game?("Joe")
      header "Accept", "application/json"
    end

    it "gets an existing player's cards" do
      uno.deal?
      get "/cards", "name" => "Jane"
      expected = {
        cards:  uno.see_cards_of("Jane"),
        status: Messages::CARDS_SUCCESS
      }
      response = JSON.parse(last_response.body, symbolize_names: true)
      expect(last_response).to be_ok
      expect(response).to eq(expected)
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

  def expect_response_to_eq(expected)
    response = JSON.parse(last_response.body, symbolize_names: true)
    expect(last_response).to be_ok
    expect(response).to eq(expected)
  end
end
