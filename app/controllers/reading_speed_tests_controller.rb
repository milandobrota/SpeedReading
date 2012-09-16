class ReadingSpeedTestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @reading_speed_test = ReadingSpeedTest.setup_for(current_user)
    @reading_speed_chart = ReadingSpeedTest.chart_for(current_user)
  end

  def create
    @reading_speed_test = ReadingSpeedTest.new(params[:reading_speed_test])
    @reading_speed_test.user = current_user

    if @reading_speed_test.save
      redirect_to @reading_speed_test, notice: "Your reading speed is #{@reading_speed_test.wpm} wpm!"
    else
      render action: "new"
    end
  end

  def show
    @reading_speed_test = ReadingSpeedTest.find(params[:id])
    @reading_speed_chart = ReadingSpeedTest.chart_for(current_user)
  end
end
