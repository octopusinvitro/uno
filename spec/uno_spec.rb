describe "Uno" do

  it "plays a turn" do
    uno = Uno.new
    player = {cards: ["foo", "bar"]}
    expect(player[:cards]).to include(uno.play_turn(player))
  end

end
