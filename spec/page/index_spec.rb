# frozen_string_literal: true

describe 'Page::Index' do
  let(:page) { Page::Index.new(status: 'status') }

  it 'has a title' do
    expect(page.title).to eq(Messages::MAIN_TITLE)
  end

  it 'has a status' do
    expect(page.join_status).to eq('status')
  end
end
