class FlashingDotsTestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @flashing_dots_test = FlashingDotsTest.setup_for(current_user)
    @flashing_dots_chart = FlashingDotsTest.chart_for(current_user)
  end

  def create
    @flashing_dots_test = FlashingDotsTest.new(params[:flashing_dots_test])
    @flashing_dots_test.user = current_user
    respond_to do |format|
      if @flashing_dots_test.save
        format.json { render json: @flashing_dots_test, status: :created, location: @flashing_dots_test }
      else
        format.json { render json: @flashing_dots_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @flashing_dots_test = FlashingDotsTest.find(params[:id])
    respond_to do |format|
      if @flashing_dots_test.update_attributes(params[:flashing_dots_test])
        format.html { redirect_to @flashing_dots_test }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @flashing_dots_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def chart
    @flashing_dots_chart = FlashingDotsTest.chart_for(current_user)
    render :layout => false
  end
end
