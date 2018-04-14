class PokerMove < ApplicationRecord
  belongs_to :user
  belongs_to :poker_game
end
