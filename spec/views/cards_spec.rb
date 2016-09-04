describe "Cards View" do
  let(:uno)  { UnoServer.new(Uno.new) }
  let(:app)  { Main.new(MainHelper.new(uno)) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe "when not acceptable MIME type" do
    it "errors" do
      get "/cards"
      expect(last_response.status).to eq(406)
    end
  end
end
