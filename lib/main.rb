class Main < Sinatra::Base

  attr_reader :uno, :helper

  def initialize(app = nil, uno, helper)
    super(app)
    @uno = uno
    @helper = helper
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

  post "/join", :provides => ["json"] do
    pass unless request.accept.first.to_s == "application/json"
    response = Response::Join.new(uno).response(params)
    response.to_json
  end

  post "/join", :provides => ["html"] do
    response = Response::Join.new(uno).response(params)
    pass unless request.accept.first.to_s == "text/html"
    pass unless response[:joined]
    @page = Page::Join.new(response: response, params: params)
    erb :join
  end

  post "/join", :provides => ["html"] do
    response = Response::Join.new(uno).response(params)
    pass unless request.accept.first.to_s == "text/html"
    status = "<p class=\"status\">#{Messages::JOIN_FAILURE}</p>"
    @page = Page::Index.new(status: status)
    erb :index
  end

  post "/join" do
    error 406
  end

  get "/deal", :provides => ["json"] do
    pass unless request.accept.first.to_s == "application/json"
    response = Response::Deal.new(uno).response
    response.to_json
  end

  get "/deal", :provides => ["html"] do
    pass unless request.accept.first.to_s == "text/html"
    response = Response::Deal.new(uno).response
    @page = Page::Deal.new(response: response)
    erb :deal
  end

  get "/deal" do
    error 406
  end

  get "/cards", :provides => ["json"] do
    pass unless request.accept.first.to_s == "application/json"
    response = helper.response_for_cards(params)
    response.to_json
  end

  get "/cards", :provides => ["html"] do
    pass unless request.accept.first.to_s == "text/html"
    response = helper.response_for_cards(params)
    @page = Page::Cards.new(response: response)
    erb :cards
  end

  get "/cards" do
    error 406
  end
end
