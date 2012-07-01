class ScrambledWordTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker,
        :content => Content.for_reading_test
      )
    end
  end
end
