# frozen_string_literal: true

require 'sinatra/base'

require_relative 'page/congrats'
require_relative 'page/error'
require_relative 'page/index'
require_relative 'page/join'
require_relative 'page/messages'
require_relative 'page/play'
require_relative 'response/deal'
require_relative 'response/join'
require_relative 'response/play'

class Main < Sinatra::Base
  attr_reader :uno

  def initialize(uno, app = nil)
    super(app)
    @uno = uno
  end

  set :port, 8080
  set :environment, :production
  set :views,         "#{settings.root}/../views"
  set :public_folder, "#{settings.root}/../public"

  configure :production, :development do
    enable :logging
  end

  not_found do
    status 404
    @page = Page::Error.new
    erb :oops
  end

  get '/' do
    @page = Page::Index.new
    erb :index
  end

  post '/join' do
    pass unless request.accept.first.to_s == 'application/json'
    response = Response::Join.new(uno, params).response
    response.to_json
  end

  post '/join' do
    pass unless request.accept.first.to_s == 'text/html'
    response = Response::Join.new(uno, params).response
    pass unless response[:joined]
    @page = Page::Join.new(response)
    erb :join
  end

  post '/join' do
    pass unless request.accept.first.to_s == 'text/html'
    @page = Page::Index.new(Messages::JOIN_FAILURE_STATUS, joined: false)
    erb :index
  end

  post '/join' do
    logger.info("Join response: #{request}")
    logger.info("Join params: #{params}")
    error 406
  end

  get '/deal' do
    pass unless request.accept.first.to_s == 'application/json'
    response = Response::Deal.new(uno).response
    response.to_json
  end

  get '/deal' do
    pass unless request.accept.first.to_s == 'text/html'
    response = Response::Deal.new(uno).response
    logger.info("DEAL :: Players cards: #{uno.players.map(&:cards)}")

    @page = Page::Play.new(response)
    erb :play
  end

  get '/deal' do
    logger.info("Deal response: #{request}")
    logger.info("Deal params: #{params}")
    error 406
  end

  post '/play' do
    pass unless request.accept.first.to_s == 'application/json'
    response = Response::Play.new(uno, params).response
    response.to_json
  end

  post '/play' do
    pass unless request.accept.first.to_s == 'text/html'
    response = Response::Play.new(uno, params).response
    logger.info("PLAY :: Players cards: #{uno.players.map(&:cards)}")
    logger.info("PLAY :: Top card: #{uno.top_card}")

    redirect '/congrats' if response[:finished]
    @page = Page::Play.new(response)
    erb :play
  end

  post '/play' do
    error 406
  end

  get '/congrats' do
    @page = Page::Congrats.new
    erb :congrats
  end
end
