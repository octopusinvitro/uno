describe "Error View" do
  let(:uno)  { UnoServer.new(Uno.new) }
  let(:app)  { Main.new(MainHelper.new(uno)) }
  let(:page) { Nokogiri::HTML(last_response.body) }

  before { get "/unknown_path" }

  it "renders the error page if there is an error" do
    expect(last_response.status).to eq(404)
  end

  it "renders the right title" do
    expect(page.css('title').text).to eq(Messages::NOT_FOUND)
  end

  it "renders the right headings" do
    expect(page.css('.main h2').text).to eq(Messages::NOT_FOUND)
  end
end
