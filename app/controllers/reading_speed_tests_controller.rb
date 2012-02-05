class ReadingSpeedTestsController < ApplicationController
  def new
    @reading_speed_test = ReadingSpeedTest.setup_for(current_user)
  end

  def create
  end

  def show
  end
end
