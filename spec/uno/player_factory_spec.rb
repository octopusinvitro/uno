describe "Player factory" do
  it "creates a player" do
    jane = PlayerFactory.new.player("Jane", ["uno", "dos"])
    expect(jane.name).to eq("Jane")
    expect(jane.cards).to eq(["uno", "dos"])
  end
end
