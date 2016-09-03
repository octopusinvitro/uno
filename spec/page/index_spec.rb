describe "Page::Index" do
  let(:page) { Page::Index.new }

  it "has a title" do
    expect(page.title).to eq(Messages::MAIN_TITLE)
  end

  it "has no status" do
    expect(page.join_status).to eq("")
  end
end
