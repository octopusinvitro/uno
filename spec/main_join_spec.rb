describe "Main" do

  let(:uno) {UnoServer.new(Uno.new)}
  let(:app) {Main.new(MainHelper.new(uno))}

  describe "when a player joins the game" do
    describe "(JSON)" do
      before(:each) do
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

    # it "returns a 406 error if not acceptable MIME type" do
    #   header "Accept", "text/xml"
    #   post "/join", {"name" => "Jane"}
    #   expect(last_response.status).to eq(406)
    # end
  end
end
