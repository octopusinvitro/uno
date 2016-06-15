# frozen_string_literal: true

require_relative 'messages'

module Page
  class Error
    def title
      Messages::NOT_FOUND
    end
  end
end
