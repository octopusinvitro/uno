describe "Main" do

  let(:uno) {UnoServer.new}
  let(:app) {Main.new(uno)}

  describe "when hitting the cards endpoint" do

    it "gets an existing player's cards" do
      uno.join_game("Jon")
      uno.deal
      get "/cards", "name" => "Jon"
      response = {
        cards:  uno.see_cards_of("Jon"),
        status: Messages::SUCCESS
      }
      expect_response_to_eq(response)
    end

    it "sends an error if player has not joined the game" do
      get "/cards", "name" => "Jon"
      response = {
        cards:  [],
        status: Messages::NOT_JOINED
      }
      expect_response_to_eq(response)
    end

    it "returns an empty response if no player is sent" do
      get "/cards"
      expect(JSON.parse(last_response.body)).to eq({})
    end
  end

  def expect_response_to_eq(response)
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body, symbolize_names: true)).to eq(response)
  end

end
