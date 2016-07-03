describe "Messages" do
  it "prints the maximum number of players" do
    expect(Messages.max_players_info(4)).to include("4")
  end
end
