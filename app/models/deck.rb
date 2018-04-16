class Deck < ApplicationRecord
  belongs_to :poker_game
  after_create :standard_deck

  private 
    def standard_deck
      52.times do |i|
        DeckCard.create(card_id: i, deck_id: self.id, poker_game_id: self.poker_game_id)
      end
    end
end
