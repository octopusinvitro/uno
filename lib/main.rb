class Main < Sinatra::Base

  attr_reader :helper

  def initialize(app = nil, helper)
    super(app)
    @helper = helper
  end

  set :port, 8080
  set :environment, :production

  post "/join" do
    helper.join_response(params).to_json
  end

  post "/deal" do
    helper.deal_response.to_json
  end

  get "/cards" do
    # @status = cards_response[:status]
    # @cards  = cards_response[:cards]
    # erb :cards
    helper.cards_response(params).to_json
  end

end
