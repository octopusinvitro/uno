class Main < Sinatra::Base

  attr_reader :uno

  def initialize(app = nil, uno)
    super(app)
    @uno = uno
  end

  set :port, 8080
  set :environment, :production

  get "/cards" do
    # @status = return_message[:status]
    # @cards  = return_message[:cards]
    # erb :cards
    cards_message.to_json
  end

  post "/join" do
    join_message.to_json
  end

  private

  def cards_message
    params.has_key?("name") ? build_cards_message : {}
  end

  def join_message
    params.has_key?("data") ? build_join_message : {}
  end

  def build_cards_message
    cards = see_cards_of(params["name"])
    {
      cards:  cards,
      status: cards_status(cards)
    }
  end

  def build_join_message
    data = parse(params["data"])
    {status: join_status(data)}
  end

  def see_cards_of(name)
    uno.see_cards_of(name)
  end

  def parse(source, params = {})
    JSON.parse(source, params)
  end

  def cards_status(cards)
    cards.empty? ? Messages::USER_NOT_FOUND : Messages::SUCCESS
  end

  def join_status(data)
    joined?(data) ? Messages::WELCOME : Messages::GAME_IS_FULL
  end

  def joined?(data)
    data.has_key?("name") && join_game(data[:name])
  end

  def join_game(name)
    uno.join_game(name)
  end

end
