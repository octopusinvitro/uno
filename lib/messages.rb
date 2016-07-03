module Messages
  NOT_FOUND     = "Page Not Found"
  JOIN_SUCCESS  = "Welcome!"
  DEAL_SUCCESS  = "Cards were dealt!"
  CARDS_SUCCESS = "Success"
  JOIN_FAILURE  = "Sorry - missing name or game not accepting new players"
  DEAL_FAILURE  = "Sorry - there are no players to deal to"
  CARDS_FAILURE = "Sorry - either you are not part of the game or you have no cards"
  MAIN_TITLE    = "UNO :: Play online"
  JOIN_TITLE    = "UNO :: Join the game"
  DEAL_TITLE    = "UNO :: Deal cards"
  CARDS_TITLE   = "UNO :: Get cards"

  def self.max_players_info(max_players)
    "Remember that there is a maximum of #{max_players} players."
  end
end
