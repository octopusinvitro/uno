class Main < Sinatra::Base

  attr_reader :uno

  def initialize(app = nil, uno)
    super(app)
    @uno = uno
  end

  set :port, 8080
  set :environment, :production
  set :views,         "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"

  not_found do
    status 404
    @page = Page::Error.new
    erb :oops
  end

  get "/" do
    @page = Page::Index.new(status: "")
    erb :index
  end

  post "/join" do
    pass unless request.accept.first.to_s == "application/json"
    response = Response::Join.new(uno).response(params)
    response.to_json
  end

  post "/join" do
    pass unless request.accept.first.to_s == "text/html"
    response = Response::Join.new(uno).response(params)
    pass unless response[:joined]
    @page = Page::Join.new(response: response, params: params)
    erb :join
  end

  post "/join" do
    pass unless request.accept.first.to_s == "text/html"
    response = Response::Join.new(uno).response(params)
    @page    = Page::Index.new(status: Messages::FAILED_JOIN_STATUS)
    erb :index
  end

  post "/join" do
    error 406
  end

  get "/deal" do
    pass unless request.accept.first.to_s == "application/json"
    response = Response::Deal.new(uno).response
    response.to_json
  end

  get "/deal" do
    pass unless request.accept.first.to_s == "text/html"
    response = Response::Deal.new(uno).response
    @page    = Page::Deal.new(response: response)
    erb :deal
  end

  get "/deal" do
    error 406
  end

  get "/cards" do
    pass unless request.accept.first.to_s == "application/json"
    response = Response::Cards.new(uno).response(params)
    response.to_json
  end

  get "/cards" do
    pass unless request.accept.first.to_s == "text/html"
    response = Response::Cards.new(uno).response(params)
    @page    = Page::Cards.new(response: response)
    erb :cards
  end

  get "/cards" do
    error 406
  end
end
