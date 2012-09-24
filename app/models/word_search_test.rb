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

    def historical_data_for(user)
      tests = WordSearchTest.where(:user_id => user.id).order("id asc").limit(30).where('created_at > ?', 1.month.ago).select([:score, :created_at])
      {:scores => tests.collect(&:score), :timestamps => tests.collect {|t| t.created_at.to_i * 1000}}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Score'}}
        ])
        f.xAxis(:title => { :text => 'Test Taken'}, :type => 'datetime', :maxZoom => 1.day * 1000)
        f.title(:text => 'Word Search Test')
        f.series(:name => 'Score', :data => user_data[:timestamps].zip(user_data[:scores]), :yAxis => 0 )
      end
    end
  end
end
