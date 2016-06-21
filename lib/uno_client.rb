class UnoClient

  attr_reader :name, :client, :base_url

  def initialize name, client, base_url
    @name     = name
    @client   = client
    @base_url = base_url
  end

  def join_game
    response = client.post(
      base_url + "/join",
      {
        data:   {name: name}.to_json,
        accept: :json
      }
    )
    JSON.parse(response, {symbolize_names: true})
  end

  def get_cards
    client.get(
      base_url + "/cards",
      {
        params: {
          name: name
        }
      }
    )
  end

  #
  # def get_cards
  #   response = RestClient.get 'http://localhost:8080/cards', {:params => {:name => @name}}
  #   puts response
  # end
  #
  # def deal
  #   response = RestClient.post 'http://localhost:8080/deal', :data =>{}.to_json, :accept => :json
  #   puts response
  # end

end
