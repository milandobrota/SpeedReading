class FlashingDotsTest < ActiveRecord::Base
  belongs_to :user

  class << self
    def setup_for(test_taker)
      previous_test = FlashingDotsTest.where(:user_id => test_taker.id).order("created_at desc").first
      new(
        :user  => test_taker,
        :level => previous_test.try(:level) || 0
      )
    end

    def historical_data_for(user)
      tests = FlashingDotsTest.where(:user_id => user.id).order("id asc").where('created_at > ?', 1.month.ago).limit(30).select([:level, :created_at])
      { :levels => tests.collect(&:level), :timestamps => tests.collect {|t| t.created_at.to_i * 1000} }
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Level'}}
        ])
        f.xAxis(:title => { :text => 'Test Taken'}, :type => 'datetime', :maxZoom => 1.day * 1000)
        f.title(:text => 'Flashing Dots')
        f.series(:name => 'Level', :data => user_data[:timestamps].zip(user_data[:levels]), :yAxis => 0 )
      end
    end
  end
end
