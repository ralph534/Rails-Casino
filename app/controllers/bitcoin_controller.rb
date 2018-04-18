class BitcoinController < ApplicationController
  def index
    @address = current_user.address
  end
end
