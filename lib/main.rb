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
    return_message.to_json
  end

  private

  def return_message
    has_name? ? build_return_message(params) : {}
  end

  def has_name?
    params.has_key?("name")
  end

  def build_return_message(params)
    return_message = {}
    return_message[:cards]  = see_cards_of(params["name"])
    return_message[:status] = status(return_message[:cards])
    return_message
  end

  def see_cards_of(name)
    uno.see_cards_of(name)
  end

  def status(cards)
    cards.empty? ? Messages::NOT_JOINED : Messages::SUCCESS
  end

end
