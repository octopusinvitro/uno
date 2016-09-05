describe "UNO::Playerfactory" do
  it "creates a player" do
    jane = UNO::PlayerFactory.new.player("Jane", ["uno", "dos"])
    expect(jane.name).to eq("Jane")
    expect(jane.cards).to eq(["uno", "dos"])
  end
end
