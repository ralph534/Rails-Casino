class PokerHand < ApplicationRecord
  belongs_to :poker_game
  belongs_to :user
end