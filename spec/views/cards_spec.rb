describe "Cards View" do
  let(:uno)  { UnoServer.new(Uno.new) }
  let(:app)  { Main.new(MainHelper.new(uno)) }
  let(:page) { Nokogiri::HTML(last_response.body) }
end
