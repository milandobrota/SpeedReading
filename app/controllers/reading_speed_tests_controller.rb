class ReadingSpeedTestsController < ApplicationController
  def new
    @reading_speed_test = ReadingSpeedTest.setup_for(current_user)
  end

  def create
    @reading_speed_test = ReadingSpeedTest.new(params[:reading_speed_test])
    if @reading_speed_test.save
      redirect_to @reading_speed_test, notice: "Your reading speed is #{@reading_speed_test.wpm}"
    else
      render action: "new"
    end
  end

  def show
  end
end
