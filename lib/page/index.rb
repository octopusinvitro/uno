# frozen_string_literal: true

require_relative 'messages'

module Page
  class Index
    attr_reader :status, :joined

    def initialize(status = nil, joined: true)
      @status = status
      @joined = joined
    end

    def title
      Messages::MAIN_TITLE
    end

    def method
      @joined ? 'POST' : 'GET'
    end

    def action
      @joined ? Messages::JOIN_ACTION : Messages::DEAL_ACTION
    end

    def class
      @joined ? 'input-container' : 'hidden'
    end

    def button_text
      @joined ? Messages::JOIN_BUTTON : Messages::PLAY_BUTTON
    end
  end
end
