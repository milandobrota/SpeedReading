class FlashingDotsTest < ActiveRecord::Base
  belongs_to :user

  class << self
    def setup_for(test_taker)
      previous_test = FlashingDotsTest.where(:user_id => test_taker.id).order("created_at desc").first
      new(
        :user  => test_taker,
        :level => previous_test.try(:level)
      )
    end

    def historical_data_for(user)
      levels = FlashingDotsTest.where(:user_id => user.id).order("id asc").limit(30).select(:level).collect(&:level)
      {:levels => levels}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Level'}},
        ])
        f.xAxis(:title => { :text => 'Test Number'} )
        f.title(:text => 'Flashing Dots')
        f.series(:name => 'Level', :data => user_data[:levels], :yAxis => 0 )
      end
    end
  end
end
