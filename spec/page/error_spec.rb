# frozen_string_literal: true

describe 'Page::Error' do
  let(:page) { Page::Error.new }

  it 'has a title' do
    expect(page.title).to eq(Messages::NOT_FOUND)
  end
end
