describe "Cards View" do
  let(:s)    { setup }
  let(:uno)  { s[:uno] }
  let(:app)  { s[:app] }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe "when not acceptable MIME type" do
    it "errors" do
      get "/cards"
      expect(last_response.status).to eq(406)
    end
  end
end
