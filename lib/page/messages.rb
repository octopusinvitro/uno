# frozen_string_literal: true

require_relative '../uno/constants'

module Messages
  NOT_FOUND = 'Page Not Found'

  JOIN_SUCCESS = 'Welcome!'
  DEAL_SUCCESS = 'Cards were dealt!'
  PLAY_SUCCESS = 'Well played!'

  JOIN_FAILURE = 'Sorry - missing name or game not accepting new players'
  DEAL_FAILURE = 'Sorry - there are no players to deal to'
  PLAY_FAILURE = 'Sorry - you have to play a card, you have no cards'
  JOIN_FAILURE_STATUS = "<p class=\"status\">#{Messages::JOIN_FAILURE}</p>"

  MAIN_TITLE = 'UNO :: Play online'
  JOIN_TITLE = 'UNO :: Join the game'
  PLAY_TITLE = 'UNO :: Play cards'
  CONGRATS_TITLE = 'UNO :: Congatulations!'

  JOIN_BUTTON = 'Join the game!'
  PLAY_BUTTON = 'Start game!'
  CHOOSE_BUTTON = 'Play card!'
  SKIP_BUTTON = 'Skip turn'
  DRAW_BUTTON = 'Draw cards and skip turn'

  CHOOSE_ICON = '#cards-icon'
  SKIP_ICON = '#deck-icon'
  DRAW_ICON = '#cards-icon'

  JOIN_ACTION = '/join'
  DEAL_ACTION = '/deal'

  MAX_PLAYERS_INFO = 'Remember that there is a maximum of ' \
                     "#{UNO::Constants::MAX_PLAYERS} players."
  GAME_IS_FULL = 'Game is full, can not add more players!'

  NO_CARD = 'a turn skip!'
  SKIP = 'Oh no! You skip one turn!'
  DRAW = 'Draw cards from the deck to continue playing.'
  CHOOSE = 'Choose a card to play from your hand:'
end
