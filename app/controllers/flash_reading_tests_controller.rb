class FlashReadingTestsController < ApplicationController
  def new
    @flash_reading_test = FlashReadingTest.setup_for(current_user)
  end

  def create
    # TODO
  end
end
