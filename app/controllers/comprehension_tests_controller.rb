class ComprehensionTestsController < ApplicationController

  def new
    @reading_speed_test = ReadingSpeedTest.find(params[:reading_speed_test_id])
    @comprehension_test = ComprehensionTest.new(
      :reading_speed_test => @reading_speed_test
    )
  end

  def create
    reading_speed_test = ReadingSpeedTest.find(params[:reading_speed_test_id])
    ComprehensionTest.check_user_answers(
      :reading_speed_test => reading_speed_test,
      :user_answers => params[:user_answers]
    )
    redirect_to reading_speed_test
  end

  def show
    # @reading_speed_test = ReadingSpeedTest.find(params[:id])
  end
end
