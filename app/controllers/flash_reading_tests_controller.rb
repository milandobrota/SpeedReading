class FlashReadingTestsController < ApplicationController
  def new
    @flash_reading_test = FlashReadingTest.setup_for(current_user)
  end

  def create
    # TODO
  end

  def chart
    @flash_reading_chart = FlashReadingTest.chart_for(current_user)
    render :layout => false
  end
end
