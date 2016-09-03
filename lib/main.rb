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
    @page = Page::Index.new
    erb :index
  end

  post "/join", :provides => ["html", "json"] do
    response = helper.response_for_join(params)
    request.accept.each do |type|
      case type.to_s
      when "text/html"
        if response[:joined]
          halt erb :join, locals: join_locals(params, response)
        else
          halt erb :index, locals: main_error_locals(response[:status])
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
        halt erb :deal, locals: deal_locals(response)
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

  def main_locals(status)
    {
      title: Messages::MAIN_TITLE,
      join_status: status
    }
  end

  def main_error_locals(status)
    {
      title: Messages::MAIN_TITLE,
      join_status: "<p class=\"status\">#{Messages::JOIN_FAILURE}</p>"
    }
  end

  def join_locals(params, response)
    {
      title:       Messages::JOIN_TITLE,
      name:        params["name"],
      join_status: response[:status],
      players:     response[:players],
      max_players_info: Constants::MAX_PLAYERS_INFO
    }
  end

  def deal_locals(response)
    {
      title:       Messages::DEAL_TITLE,
      deal_status: response[:status],
      players:     response[:players],
      top_card:    response[:top_card]
    }
  end
end
