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
  end
end
