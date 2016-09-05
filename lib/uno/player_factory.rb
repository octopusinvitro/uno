module UNO
  class PlayerFactory
    def player(name, cards)
      Player.new(name, cards)
    end
  end
end
