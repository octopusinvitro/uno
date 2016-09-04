describe "Main" do

  let(:uno) {UnoServer.new(Uno.new)}
  let(:app) {Main.new(MainHelper.new(uno))}

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
