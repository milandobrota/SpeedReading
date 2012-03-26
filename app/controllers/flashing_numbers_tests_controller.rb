class FlashingNumbersTestsController < ApplicationController
  def new
    @flashing_numbers_test = FlashingNumbersTest.setup_for(current_user)
  end

  def create
    raise params.inspect
  end
end
