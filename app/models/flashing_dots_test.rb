class FlashingDotsTest < ActiveRecord::Base
  belongs_to :user

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker
      )
    end
  end
end
