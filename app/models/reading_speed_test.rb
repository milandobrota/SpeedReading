class ReadingSpeedTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  validates_presence_of :user, :content

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker,
        :content => Content.for_reading_test
      )
    end

    def historical_data_for(user)
      reading_speeds = []
      comprehension = []
      tests = ReadingSpeedTest.where(:user_id => user.id).order("id asc").limit(30).select([:wpm, :comprehension_rate]).all
      tests.each do |test|
        reading_speeds << test.wpm
        comprehension << test.comprehension_rate.to_i
      end
      {:reading_speeds => reading_speeds, :comprehension => comprehension}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Reading Speed'}},
          {:title => {:text => 'Comprehension Rate'}, :max => 100, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Number'} )
        f.title(:text => 'Speed Reading')
        f.series(:name => 'Reading Speed', :data => user_data[:reading_speeds], :yAxis => 0 )
        f.series(:name => 'Comprehension Rate', :data => user_data[:comprehension], :yAxis => 1 )
      end
    end
  end
end
