class ComprehensionTestsController < ApplicationController

  def new
    set_reading_test
    @comprehension_test = ComprehensionTest.new(
      :reading_test => @reading_test
    )
  end

  def create
    set_reading_test
    ComprehensionTest.check_user_answers(
      :reading_test => @reading_test,
      :user_answers => params[:user_answers]
    )
    redirect_to @reading_test
  end

  def show
    set_reading_test
  end

  def set_reading_test
    @reading_test = params[:reading_speed_test_id] ?
      ReadingSpeedTest.find(params[:reading_speed_test_id]) :
      ScrambledWordTest.find(params[:scrambled_word_test_id])
  end
end
