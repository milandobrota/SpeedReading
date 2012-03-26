class FlashingNumbersTest < ActiveRecord::Base
  belongs_to :user

  attr_accessor :left_number, :right_number

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker
      )
    end
  end
end
