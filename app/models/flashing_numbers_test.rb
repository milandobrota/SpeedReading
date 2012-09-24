class FlashingNumbersTest < ActiveRecord::Base
  belongs_to :user

  attr_accessor :left_number, :right_number

  class << self
    def setup_for(test_taker)
      previous_test = FlashingNumbersTest.where(:user_id => test_taker.id).order("created_at desc").first
      new(
        :user             => test_taker,
        :distance         => previous_test.try(:distance),
        :number_of_digits => previous_test.try(:number_of_digits)
      )
    end

    def historical_data_for(user)
      distances = []
      numbers_of_digits = []
      timestamps = []
      tests = FlashingNumbersTest.where(:user_id => user.id).order("id asc").where('created_at > ?', 1.month.ago).limit(30).select([:distance, :number_of_digits, :created_at]).all
      tests.each do |test|
        distances << test.distance
        numbers_of_digits << test.number_of_digits
        timestamps << test.created_at.to_i * 1000
      end
      {:distances => distances, :numbers_of_digits => numbers_of_digits, :timestamps => timestamps}
    end

    # TODO: add user specific f-ty
    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Distance'}},
          {:title => {:text => 'Number of Digits'}, :max => 6, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Taken'}, :type => 'datetime', :maxZoom => 1.day * 1000)
        f.title(:text => 'Flashing Numbers')
        f.series(:name => 'Distance', :data => user_data[:timestamps].zip(user_data[:distances]), :yAxis => 0 )
        f.series(:name => 'Number of Digits', :data => user_data[:timestamps].zip(user_data[:numbers_of_digits]), :yAxis => 1 )
      end
    end
  end
end
