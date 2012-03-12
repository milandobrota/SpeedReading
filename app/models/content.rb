class Content < ActiveRecord::Base
  has_many :questions, :dependent => :delete_all

  def word_count
    body.scan(/\b/).size / 2
  end

  class << self
    def for_reading_speed_test
      first
    end

    def for_find_the_word_test
      first
    end
  end

end
