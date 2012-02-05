class Content < ActiveRecord::Base

  class << self
    def for_reading_speed_test
      first
    end
  end

end
