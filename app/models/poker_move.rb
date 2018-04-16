class PokerMove < ApplicationRecord
  belongs_to :user


  def to_s 
    case self.move
    when 'call'
      "#{User.find(self.user_id).username} called!"
    when 'raise'
      "#{User.find(self.user_id).username} raised by #{raise_amt}!"
    end
  end
end
