class WordSearchTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  attr_accessor :word

  def pick_a_word!
    words =  content.body.split(/\b/).select {|w| w =~ /\w/}
    @word = words[rand(words.size)].downcase
  end

  class << self
    def setup_for(test_taker)
      res = new(
        :user => test_taker,
        :content => Content.for_find_the_word_test
      )
      res.pick_a_word!
      res
    end
  end
end
