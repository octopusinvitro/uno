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

  post "/deal" do
    deal_message.to_json
  end

  private

  def cards_message
    params.has_key?("name") ? build_cards_message : {}
  end

  def join_message
    params.has_key?("data") ? build_join_message : {}
  end

  def deal_message
    {status: deal_status}
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

  def cards_status(cards)
    cards.empty? ? Messages::CARDS_FAILURE : Messages::CARDS_SUCCESS
  end

  def join_status(data)
    joined?(data) ? Messages::JOIN_SUCCESS : Messages::JOIN_FAILURE
  end

  def deal_status
    deal? ? Messages::DEAL_SUCCESS : Messages::DEAL_FAILURE
  end

  def joined?(data)
    data.has_key?("name") && join_game(data[:name])
  end

  def see_cards_of(name)
    uno.see_cards_of(name)
  end

  def join_game(name)
    uno.join_game(name)
  end

  def deal?
    uno.deal
  end

  def parse(source, params = {})
    JSON.parse(source, params)
  end

end
