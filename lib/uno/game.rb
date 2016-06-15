# frozen_string_literal: true

require_relative 'constants'
require_relative 'deck'

module UNO
  class Game
    AMOUNT_OF_CARDS_TO_DRAW = {
      skip: 0,
      draw2: 2,
      draw4: 4,
      reverse: 0
    }.freeze

    attr_reader :pool

    def initialize(deck = Deck.build_deck)
      @deck = deck
      reset
    end

    def flip_top_card
      pool.unshift(pool.pop)
    end

    def top_card
      pool.first
    end

    def deal_cards(players)
      @pool.shuffle!

      players.each do |player|
        player.cards = pool.pop(Constants::MAX_CARDS)
      end
    end

    def play(players, top, start = [])
      players.each_with_object(start) do |player, hands_accumulator|
        # hands = players.each_with_object(start) do |player, hands_accumulator|
        # break hands_accumulator if play_action_card(:reverse, player, top)

        next if player.finished?

        card = play_with(player, top)
        top = card || top
        hands_accumulator << { name: player.name, card: card }
      end

      # return reverse_game(players.dup, top, hands) if Deck.reverse?(top)

      # hands
    end

    def human_play(player, card, top)
      if card
        player.play(card)
        pool.unshift(card)
        return if player.finished?
      else
        play_with(player, top)
      end

      { name: player.name, card: card }
    end

    def reset
      @pool = deck.dup
      @enabled = { skip: 0, draw2: 0, draw4: 0, reverse: 0 }
    end

    private

    attr_reader :deck, :enabled

    def play_with(player, top)
      return if follow_action_card(:skip, player, top)

      return if follow_action_card(:draw2, player, top)

      return if follow_action_card(:draw4, player, top)

      play_turn(player, top)
    end

    def follow_action_card(action, player, top)
      return unless Deck.send("#{action}?", top)

      unless enabled[action].zero?
        @enabled[action] = 0
        return
      end

      player.draw(pool.pop(AMOUNT_OF_CARDS_TO_DRAW[action]))
      @enabled[action] = 1
    end

    def play_turn(player, top)
      card = player.play_turn(top) || retry_play_turn(player, top)
      pool.unshift(card) if card
      card
    end

    def retry_play_turn(player, top)
      player.draw(pool.pop(1))
      player.play_turn(top)
    end

    def reverse_game(players, top, hands)
      players.push(players.shift(hands.size - 1)).flatten!.reverse!
      play(players, top, hands)
    end
  end
end
