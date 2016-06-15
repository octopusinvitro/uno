# frozen_string_literal: true

require 'page/error'

RSpec.describe Page::Error do
  let(:page) { described_class.new }

  it 'has a title' do
    expect(page.title).not_to be_empty
  end
end
