describe "Index View" do
  let(:uno)  { UnoServer.new(Uno.new) }
  let(:app)  { Main.new(MainHelper.new(uno)) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  describe "when loading the main page" do
    before { get "/" }

    it "renders the main page" do
      expect(last_response).to be_ok
    end

    it "renders the right title" do
      expect(page.css('title').text).to eq(Messages::MAIN_TITLE)
    end

    it "renders the right headings" do
      expect(page.css('.main h2').text).to eq(Messages::MAIN_TITLE)
    end

    it "renders the join status" do
      expect(page.css('body').text).to include("")
    end
  end
end
