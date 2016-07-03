class Main < Sinatra::Base

  attr_reader :helper

  def initialize(app = nil, helper)
    super(app)
    @helper = helper
  end

  set :port, 8080
  set :environment, :production
  set :views,         "#{settings.root}/../views"

  not_found do
    status 404
    erb :oops, locals: error_locals
  end

  get "/" do
    erb :index, locals: main_locals("")
  end

  post "/join", :provides => ['html', 'json'] do
    response = helper.join_response(params)
    request.accept.each do |type|
      case type.to_s
      when 'text/html'
        if response[:joined]
          halt erb :join, locals: join_locals(params, response)
        else
          halt erb :index, locals: main_locals(response[:status])
        end
      when 'application/json'
        halt response.to_json
      end
    end

  end

  get "/deal" do
    response = helper.deal_response
    request.accept.each do |type|
      case type.to_s
      when 'text/html'
        halt erb :deal, locals: deal_locals(params, response)
      when 'application/json'
        halt response.to_json
      end
    end
  end

  get "/cards" do
    @title  = Messages::CARDS_TITLE
    @status = helper.cards_response(params)[:status]
    @cards  = helper.cards_response(params)[:cards]

    helper.cards_response(params).to_json
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

  def join_locals(params, response)
    {
      title:       Messages::JOIN_TITLE,
      name:        params["name"],
      join_status: response[:status],
      players:     response[:players],
      max_players_info: max_players_info
    }
  end

  def deal_locals(params, response)
    {
      title:       Messages::DEAL_TITLE,
      deal_status: response[:status],
      players:     response[:players][0..-1],
      top_card:    response[:top_card]
    }
  end

  def max_players_info
    Messages.max_players_info(helper.max_players)
  end
end
