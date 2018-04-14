class BlackjackHand < ApplicationRecord
  belongs_to :blackjack_game
  belongs_to :card1, class_name: 'Card', foreign_key: 'card1_id'
  belongs_to :card2, class_name: 'Card', foreign_key: 'card2_id'
  belongs_to :card3, class_name: 'Card', foreign_key: 'card3_id', optional: true
  belongs_to :card4, class_name: 'Card', foreign_key: 'card4_id', optional: true
  belongs_to :card5, class_name: 'Card', foreign_key: 'card5_id', optional: true
  belongs_to :card6, class_name: 'Card', foreign_key: 'card6_id', optional: true
  belongs_to :card7, class_name: 'Card', foreign_key: 'card7_id', optional: true
  has_many :blackjack_moves
  scope :for_player, -> { find_by(holder: 'player') }
  scope :for_dealer, -> { find_by(holder: 'dealer') }
  after_save :set_hand_value
  after_update :set_hand_value

  def initial_deal
    [self.card1, self.card2]
  end

  def cards
    [self.card1, self.card2, self.card3, self.card4,
     self.card5, self.card6, self.card7].select { |card| card.class == Card }
  end

  def hits
    self.blackjack_moves.where(stay: false).map(&:card)
  end

  def card_count
    cards.count
  end

  private 
    def set_hand_value
      sum = 0
      self.cards.each { |card| sum += card.value }
      aces = ace_count
      if aces >= 1 && sum > 21
        until sum <= 21 do
          sum -= 10
          aces -= 1
          break if aces == 0
        end
      end
      self.update_column(:value, sum)
    end

    def ace_count
      self.cards.select { |card| card.rank == 'A' }.count
    end
end
