class Main < Sinatra::Base

  attr_reader :helper

  def initialize(app = nil, helper)
    super(app)
    @helper = helper
  end

  set :port, 8080
  set :environment, :production
  set :views,         "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"

  not_found do
    status 404
    erb :oops, locals: error_locals
  end

  get "/" do
    @page = Page::Index.new(status: "")
    erb :index
  end

  post "/join", :provides => ["html", "json"] do
    response = helper.response_for_join(params)
    request.accept.each do |type|
      case type.to_s
      when "text/html"
        if response[:joined]
          @page = Page::Join.new(response: response, params: params)
          halt erb :join
        else
          status = "<p class=\"status\">#{Messages::JOIN_FAILURE}</p>"
          @page = Page::Index.new(status: status)
          halt erb :index
        end
      when "application/json"
        halt response.to_json
      end
    end

  end

  get "/deal", :provides => ["html", "json"] do
    response = helper.response_for_deal
    request.accept.each do |type|
      case type.to_s
      when "text/html"
        @page = Page::Deal.new(response: response)
        halt erb :deal
      when "application/json"
        halt response.to_json
      end
    end
  end

  get "/cards" do
    @title  = Messages::CARDS_TITLE
    @status = helper.response_for_cards(params)[:status]
    @cards  = helper.response_for_cards(params)[:cards]

    helper.response_for_cards(params).to_json
  end

  private

  def error_locals
    {title: Messages::NOT_FOUND}
  end
end
