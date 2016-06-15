# frozen_string_literal: true

require 'uno/player_factory'

RSpec.describe UNO::PlayerFactory do
  it 'creates a player' do
    jane = described_class.new.player('Jane')
    expect(jane.name).to eq('Jane')
    expect(jane.cards).to eq([])
  end

  it 'creates a player with cards' do
    jane = described_class.new.player('Jane', %w[uno dos])
    expect(jane.name).to eq('Jane')
    expect(jane.cards).to eq(%w[uno dos])
  end
end
