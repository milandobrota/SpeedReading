class FlashReadingTestsController < ApplicationController
  def new
    @flash_reading_test = FlashReadingTest.setup_for(current_user)
    @flash_reading_chart = FlashReadingTest.chart_for(current_user)
  end

  def create
    @flash_reading_test = FlashReadingTest.new(params[:flash_reading_test])
    @flash_reading_test.user = current_user
    respond_to do |format|
      if @flash_reading_test.save
        format.json { render json: @flash_reading_test, status: :created, location: @flash_reading_test }
      else
        format.json { render json: @flash_reading_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def chart
    @flash_reading_chart = FlashReadingTest.chart_for(current_user)
    render :layout => false
  end
end
