module Page
  class Index
    def initialize(status:)
      @status = status
    end

    def title
      Messages::MAIN_TITLE
    end

    def join_status
      status
    end

    private

    attr_reader :status
  end
end
