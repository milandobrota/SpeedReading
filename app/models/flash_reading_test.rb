class FlashReadingTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker,
        :content => Content.for_reading_test
      )
    end

    def historical_data_for(user)
      reading_speeds = []
      word_throughputs = []
      tests = FlashReadingTest.where(:user_id => user.id).order("id asc").select([:reading_speed, :word_throughput]).all
      tests.each do |test|
        reading_speeds << test.reading_speed
        word_throughputs << test.word_throughput
      end
      {:reading_speeds => reading_speeds, :word_throughputs => word_throughputs}
    end

    # TODO: add user specific f-ty
    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Reading Speed'}, :max => 100},
          {:title => {:text => 'Word Throughput'}, :max => 6, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Number'} )
        f.title(:text => 'Flash Reading')
        f.series(:name => 'Reading Speed', :data => user_data[:reading_speeds], :yAxis => 0 )
        f.series(:name => 'Word Throughput', :data => user_data[:word_throughputs], :yAxis => 1 )
      end
    end

  end
end
