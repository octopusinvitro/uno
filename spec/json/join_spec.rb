describe "Join (JSON)" do
  let(:s)   { setup }
  let(:uno) { s[:uno] }
  let(:app) { s[:app] }

  describe "when a player joins the game" do
    before do
      header "Accept", "application/json"
    end

    it "welcomes the player" do
      post "/join", {"name" => "Jane"}
      expect_to_have_joined(true, Messages::JOIN_SUCCESS)
    end

    it "sends an error message if no name was sent" do
      post "/join", {}
      expect_to_have_joined(false, Messages::JOIN_FAILURE)
    end

    it "sends an error message if no data was sent" do
      post "/join"
      expect_to_have_joined(false, Messages::JOIN_FAILURE)
    end

    it "sends an error message if player could not join the game" do
      fill_the_game
      post "/join", {"name" => "Jane"}
      expect_to_have_joined(false, Messages::JOIN_FAILURE)
    end
  end

  def expect_to_have_joined(joined, status)
    response = JSON.parse(last_response.body, symbolize_names: true)
    expect(last_response).to be_ok
    expect(response[:joined]).to be(joined)
    expect(response[:status]).to eq(status)
  end
end
