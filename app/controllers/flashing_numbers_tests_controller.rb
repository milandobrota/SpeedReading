class FlashingNumbersTestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @flashing_numbers_test = FlashingNumbersTest.setup_for(current_user)
    @flashing_numbers_chart = FlashingNumbersTest.chart_for(current_user)
  end

  def create
    @flashing_numbers_test = FlashingNumbersTest.new(params[:flashing_numbers_test])
    @flashing_numbers_test.user = current_user
    respond_to do |format|
      if @flashing_numbers_test.save
        format.json { render json: @flashing_numbers_test, status: :created, location: @flashing_numbers_test }
      else
        format.json { render json: @flashing_numbers_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @flashing_numbers_test = FlashingNumbersTest.find(params[:id])
    respond_to do |format|
      if @flashing_numbers_test.update_attributes(params[:flashing_numbers_test])
        format.html { redirect_to @flashing_numbers_test }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @flashing_numbers_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def chart
    @flashing_numbers_chart = FlashingNumbersTest.chart_for(current_user)
    render :layout => false
  end
end
