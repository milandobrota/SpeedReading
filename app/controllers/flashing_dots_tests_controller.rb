class FlashingDotsTestsController < ApplicationController
  def new
    @flashing_dots_test = FlashingDotsTest.setup_for(current_user)
  end

  def create
    # TODO
  end
end
