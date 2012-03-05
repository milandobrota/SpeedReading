class Content < ActiveRecord::Base
  has_many :questions, :dependent => :delete_all

  class << self
    def for_reading_speed_test
      first
    end
  end

end
