class ScrambledWordTestsController < ApplicationController
  def new
    @scrambled_word_test = ScrambledWordTest.setup_for(current_user)
  end

  def create
    @scrambled_word_test = ScrambledWordTest.new(params[:scrambled_word_test])
    @scrambled_word_test.user = current_user

    if @scrambled_word_test.save
      redirect_to @scrambled_word_test, notice: "Your reading speed is #{@scrambled_word_test.wpm}"
    else
      render action: "new"
    end
  end

  def show
    @scrambled_word_test = ScrambledWordTest.find(params[:id])
    @scrambled_word_chart = ScrambledWordTest.chart_for(current_user)
  end
end
