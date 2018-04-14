class PokerHand < ApplicationRecord
  belongs_to :poker_round
  belongs_to :user
end
