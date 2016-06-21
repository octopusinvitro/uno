describe "UnoClient" do

  let(:client) {double(RestClient)}
  let(:url)    {"http://localhost:8080"}
  let(:uno)    {UnoClient.new("Jon", client, url)}

  describe "when joining the game" do

    before(:each) do
      allow(client).to receive(:post).and_return('{"response_key": "response_value"}')
    end

    it "sends a POST request to join the game" do
      uno.join_game
      expect(client).to have_received(:post).once
    end

    it "sends a POST request with the right parameters" do
      params = {
        data: '{"name":"Jon"}',
        accept: :json
      }
      uno.join_game
      expect(client).to have_received(:post).with(url + "/join", params)
    end

    it "returns the right response" do
      expect(uno.join_game).to eq( {response_key: "response_value"} )
    end

  end

  describe "when getting the cards" do

    before(:each) do
      allow(client).to receive(:get).and_return('{"response_key": "response_value"}')
    end

    it "sends a GET request to fetch the cards" do
      uno.get_cards
      expect(client).to have_received(:get).once
    end

    it "sends a GET request with the right parameters" do
      params = {name: "Jon"}
      uno.get_cards
      expect(client).to have_received(:get).with(url + "/cards", {params: params})
    end

    it "returns the right response" do
      expect(uno.get_cards).to eq('{"response_key": "response_value"}')
    end

  end

end
