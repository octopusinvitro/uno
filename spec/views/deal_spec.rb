describe "Deal View" do
  let(:uno) { UnoServer.new(Uno.new) }
  let(:app) { Main.new(MainHelper.new(uno)) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe "when there are players" do
    before(:each) do
      uno.join_game?("Jane")
      uno.join_game?("Joe")
      header "Accept", "text/html"
      get "/deal"
    end

    it "renders the deal view" do
      expect(last_response).to be_ok
    end

    it "renders title and headings" do
      expect(page.css('title').text).to eq(Messages::DEAL_TITLE)
      expect(page.css('.main h2').text).to eq(Messages::DEAL_TITLE)
    end

    it "renders the join status message" do
      expect(page.css('.status').text).to include(Messages::DEAL_SUCCESS)
    end

    it "renders a list of players" do
      expect(page.css('.players-joined li').first.text).to include("Jane")
    end

    it "doesn't render the current player" do
      expect(page.css('.players-joined li').last.text).not_to include("Joe")
    end

    # it "renders the players cards" do
    #   expect(page.css('.players-joined li').first.text).to include(uno.players.first[:cards].first)
    # end
  end

  describe "when done" do
    let(:helper) {double(MainHelper)}
    let(:app)    {Main.new(helper)}

    it "renders the top card" do
      uno.join_game?("Jane")
      uno.join_game?("Joe")
      response = {deal_status: "irrelevant", players: uno.players, top_card: "topcard"}
      allow(helper).to receive(:response_for_deal).and_return(response)
      header "Accept", "text/html"
      get "/deal"
      expect(last_response.body).to include("topcard")
    end
  end

  describe "when there are no players" do
    # it "errors" do
    #   get "/deal"
    #   expect(last_response.status).to eq(500)
    # end
  end
end
