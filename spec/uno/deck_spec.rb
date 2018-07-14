# frozen_string_literal: true

class DeckTester
  attr_reader :deck
  def initialize
    @deck = UNO::Deck.build_deck
  end
end

describe 'UNO::Deck' do
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
    it 'detects a skip card' do
      expect(UNO::Deck.skip?('skip-red')).to be(true)
      expect(UNO::Deck.skip?('0-red')).to be(false)
    end

    it 'detects a draw2 card' do
      expect(UNO::Deck.draw2?('draw2-red')).to be(true)
      expect(UNO::Deck.draw2?('0-red')).to be(false)
    end

    it 'detects a draw4 card' do
      expect(UNO::Deck.draw4?('draw4-red')).to be(true)
      expect(UNO::Deck.draw4?('0-red')).to be(false)
    end

    it 'detects a reverse card' do
      expect(UNO::Deck.reverse?('reverse-red')).to be(true)
      expect(UNO::Deck.reverse?('0-red')).to be(false)
    end
  end
end
