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

  def deal
    client.post(
      base_url + "/deal",
      {
        data: {}.to_json,
        accept: :json
      }
    )
  end

end
