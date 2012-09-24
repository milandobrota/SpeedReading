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

    def historical_data_for(user)
      reading_speeds = []
      comprehension = []
      timestamps = []
      tests = ScrambledWordTest.where(:user_id => user.id).order("id asc").limit(30).where('created_at > ?', 1.month.ago).select([:wpm, :comprehension_rate, :created_at]).all
      tests.each do |test|
        reading_speeds << test.wpm
        comprehension << test.comprehension_rate.to_i
        timestamps << test.created_at.to_i * 1000
      end
      {:reading_speeds => reading_speeds, :comprehension => comprehension, :timestamps => timestamps}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Reading Speed'}},
          {:title => {:text => 'Comprehension Rate'}, :max => 100, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Taken'}, :type => 'datetime', :maxZoom => 1.day * 1000 )
        f.title(:text => 'Scrambled Word Reading')
        f.series(:name => 'Reading Speed', :data => user_data[:timestamps].zip(user_data[:reading_speeds]), :yAxis => 0 )
        f.series(:name => 'Comprehension Rate', :data => user_data[:timestamps].zip(user_data[:comprehension]), :yAxis => 1 )
      end
    end
  end
end
