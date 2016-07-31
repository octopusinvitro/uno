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

    describe "(views)" do
      before(:each) do
        header "Accept", "text/html"
      end

      it "renders the join view if join was successful" do
        post "/join", {"name" => "Jane"}
        expect_body_to_include(Messages::JOIN_TITLE, Messages::JOIN_SUCCESS)
        expect(last_response.body).to include("a maximum of 4 players")
      end

      it "renders the players" do
        post "/join", {"name" => "Jane"}
        post "/join", {"name" => "Joe"}
        expect(last_response.body).to include("Jane")
        expect(last_response.body).to include("Joe (you)")
      end

      it "renders the index page page if no name was sent" do
        post "/join", {"name" => ""}
        expect_body_to_include(Messages::MAIN_TITLE, Messages::JOIN_FAILURE)
      end

      it "renders the index page page if game is full" do
        fill_the_game
        post "/join", {"name" => "Jane"}
        expect_body_to_include(Messages::MAIN_TITLE, Messages::JOIN_FAILURE)
      end
    end

    # it "returns a 406 error if not acceptable MIME type" do
    #   header "Accept", "text/xml"
    #   post "/join", {"name" => "Jane"}
    #   expect(last_response.status).to eq(406)
    # end
  end
end
