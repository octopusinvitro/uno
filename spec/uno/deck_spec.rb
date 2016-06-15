# frozen_string_literal: true

require 'uno/deck'

class DeckTester
  def deck
    @deck ||= UNO::Deck.build_deck
  end
end

RSpec.describe UNO::Deck do
  let(:deck) { DeckTester.new.deck }

  describe '#build_deck' do
    it 'includes all reds' do
      expect_count_to_be(18 + 6 + 3, 'red')
    end

    it 'includes all yellows' do
      expect_count_to_be(27, 'yellow')
    end

    it 'includes all greens' do
      expect_count_to_be(27, 'green')
    end

    it 'includes all blues' do
      expect_count_to_be(27, 'blue')
    end

    it 'includes all skips' do
      expect_count_to_be(8, 'skip')
    end

    it 'includes all reverses' do
      expect_count_to_be(8, 'reverse')
    end

    it 'includes all draw2s' do
      expect_count_to_be(8, 'draw2')
    end

    it 'includes all zeros' do
      expect_count_to_be(4, '0-')
    end

    it 'includes all draw4s' do
      expect_count_to_be(4, 'draw4')
    end

    it 'includes all wilds' do
      expect_count_to_be(4, 'wild')
    end

    it 'has a total of 108 cards' do
      expect(deck.length).to eq(108)
    end

    it "can't be modified" do
      expect { DeckTester.new.deck << 'foo' }.to raise_error(RuntimeError)
    end

    def expect_count_to_be(count, cards)
      expect(deck.join(' ').scan(cards).length).to eq(count)
    end
  end

  describe 'special cards' do
    it 'knows if card is a skip card' do
      expect(described_class.skip?('skip-red')).to be(true)
    end

    it 'knows if card is not a skip card' do
      expect(described_class.skip?('0-red')).to be(false)
    end

    it 'knows if card is a draw2 card' do
      expect(described_class.draw2?('draw2-red')).to be(true)
    end

    it 'knows if card is not a draw2 card' do
      expect(described_class.draw2?('0-red')).to be(false)
    end

    it 'knows if card is a draw4 card' do
      expect(described_class.draw4?('draw4-red')).to be(true)
    end

    it 'knows if card is not a draw4 card' do
      expect(described_class.draw4?('0-red')).to be(false)
    end

    it 'knows if card is a wild card' do
      expect(described_class.wild?('wild-red')).to be(true)
    end

    it 'knows if card is not a wild card' do
      expect(described_class.wild?('0-red')).to be(false)
    end
  end

  describe '#find_with_same_number_or_color' do
    it 'finds cards if they have the same number' do
      selected = described_class.find_with_same_number_or_color(
        %w[8-red 2-green], '8-blue'
      )
      expect(selected).to eq(%w[8-red])
    end

    it 'finds cards if they have the same color' do
      selected = described_class.find_with_same_number_or_color(
        %w[8-red 2-green], '1-red'
      )
      expect(selected).to eq(%w[8-red])
    end

    it 'finds cards if both cards are skip cards' do
      selected = described_class.find_with_same_number_or_color(
        %w[skip-red 2-green], 'skip-blue'
      )
      expect(selected).to eq(%w[skip-red])
    end

    it 'finds cards if both cards are draw2 cards' do
      selected = described_class.find_with_same_number_or_color(
        %w[draw2-red 2-green], 'draw2-blue'
      )
      expect(selected).to eq(%w[draw2-red])
    end

    it 'finds cards if both cards are draw4 cards' do
      selected = described_class.find_with_same_number_or_color(
        %w[draw4-red 2-green], 'draw4-blue'
      )
      expect(selected).to eq(%w[draw4-red])
    end

    it 'finds cards if both cards are wild cards' do
      selected = described_class.find_with_same_number_or_color(
        %w[wild-red 2-green], 'wild-blue'
      )
      expect(selected).to eq(%w[wild-red])
    end

    it 'finds cards if both cards are reverse cards' do
      selected = described_class.find_with_same_number_or_color(
        %w[reverse-red 2-green], 'reverse-blue'
      )
      expect(selected).to eq(%w[reverse-red])
    end

    it 'finds no cards if cards have different number and color' do
      selected = described_class.find_with_same_number_or_color(
        %w[8-red 2-green], 'draw4-blue'
      )
      expect(selected).to be_empty
    end
  end
end
