class FlashReadingTestsController < ApplicationController
  def new
    @flash_reading_test = FlashReadingTest.setup_for(current_user)
    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:defaultSeriesType] = 'area'
      f.yAxis([
        {:title => {:text => 'Speed'}, :max => 100},
        {:title => {:text => 'Word Throughput'}, :max => 6, :opposite => 'true'}
      ])
      f.xAxis(:title => { :text => 'Test Number'} )
      f.title(:text => 'Flash Reading')
      f.series(:name => 'Speed', :data => [11, 33, 55, 61, 62, 68, 70, 74, 70, 69, 71, 72, 73, 90, 80, 90], :yAxis => 0 )
      f.series(:name => 'Word Throughput', :data=> [1, 2, 3, 1, 2, 3, 3, 3,3,3,3,3,4,3,4,4], :yAxis => 1 )
    end
  end

  def create
    # TODO
  end
end
