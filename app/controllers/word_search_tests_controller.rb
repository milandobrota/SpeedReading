class WordSearchTestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @word_search_test = WordSearchTest.setup_for(current_user)
    @word_search_chart = WordSearchTest.chart_for(current_user)
  end

  def create
    @word_search_test = WordSearchTest.new(params[:word_search_test])
    if @word_search_test.save
      flash[:notice] = "Your score is #{@word_search_test.score}"
      redirect_to @word_search_test
    else
      render action: "new"
    end
  end

  def show
    @word_search_test = WordSearchTest.find(params[:id])
    @word_search_chart = WordSearchTest.chart_for(current_user)
  end
end
