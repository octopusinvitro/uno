# frozen_string_literal: true

describe 'UNO::Game' do
  let(:mia)  { UNO::Player.new('Mia')  }
  let(:jane) { UNO::Player.new('Jane') }
  let(:joe)  { UNO::Player.new('Joe')  }

  describe 'when operating with the deck' do
    let(:deck) { %w[uno dos tres] }
    let(:game) { UNO::Game.new(deck) }

    it 'flips top card of the deck' do
      game.flip_top_card
      expect(game.pool.first).to eq('tres')
    end

    it 'shows the top card' do
      expect(game.top_card).to eq('uno')
    end

    it 'resets the game' do
      game.flip_top_card
      game.reset
      expect(game.pool).to eq(deck)
    end
  end

  describe 'when dealing cards' do
    let(:deck)      { UNO::Deck.build_deck }
    let(:game)      { UNO::Game.new }
    let(:max_cards) { UNO::Constants::MAX_CARDS }

    it 'delivers the maximum cards to each player' do
      game.deal_cards([jane, joe])
      expect(jane.cards.size).to eq(max_cards)
      expect(joe.cards.size).to eq(max_cards)
    end

    it 'shuffles the cards' do
      game.deal_cards([jane])
      expect(jane.cards).not_to eq(deck[0...max_cards])
    end
  end

  describe 'when playing' do
    let(:max_cards) { UNO::Constants::MAX_CARDS }

    it 'plays normally' do
      game       = UNO::Game.new
      jane.cards = ['3-green', '4-red']
      joe.cards  = ['5-blue',  '4-yellow']
      expected   = [
        { name: 'Jane', card: '4-red' },
        { name: 'Joe',  card: '4-yellow' }
      ]
      expect(game.play([jane, joe], '4-blue')).to eq(expected)
    end

    it 'makes a player draw a card and play it' do
      deck       = ['3-blue']
      game       = UNO::Game.new(deck)
      jane.cards = ['3-green', '4-red']
      expected   = [{ name: 'Jane', card: '3-blue' }]
      expect(game.play([jane], '2-blue')).to eq(expected)
    end

    describe 'special cards' do
      it 'skips next player with skip card' do
        game       = UNO::Game.new
        jane.cards = ['3-green', 'skip-red']
        joe.cards  = ['5-blue',  '4-yellow']
        expected   = [
          { name: 'Jane', card: 'skip-red' }, { name: 'Joe', card: '' }
        ]
        expect(game.play([jane, joe], '4-red')).to eq(expected)
      end

      it 'makes a player draw 2 cards and skip turn' do
        deck       = ['3-blue', '2-red']
        game       = UNO::Game.new(deck)
        jane.cards = ['3-green', '4-red']
        expected   = [{ name: 'Jane', card: '' }]
        expect(game.play([jane], 'draw2-red')).to eq(expected)
        expect(jane.cards).to eq(['3-green', '4-red'] + deck)
      end

      it 'makes a player draw 4 cards and skip turn' do
        deck       = ['4-yellow', '3-blue', '2-red', '1-blue']
        game       = UNO::Game.new(deck)
        jane.cards = ['3-green', '4-red']
        expected   = [{ name: 'Jane', card: '' }]
        expect(game.play([jane], 'draw4-red')).to eq(expected)
        expect(jane.cards).to eq(['3-green', '4-red'] + deck)
      end

      # it "can play in reverse" do
      #   game       = UNO::Game.new
      #   jane.cards = ["0-yellow", "1-yellow"]
      #   joe.cards  = ["5-blue", "reverse-yellow"]
      #   expected   = [
      #     {name: "Jane", card: "0-yellow"},
      #     {name: "Joe",  card: "reverse-yellow"},
      #     {name: "Jane", card: "1-yellow"},
      #   ]
      #   expect(game.play([jane, joe], "0-green")).to eq(expected)
      # end
    end
  end
end
