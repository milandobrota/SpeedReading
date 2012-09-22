class SynonymsAndAntonymsTestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.setup_for(current_user)
    @synonyms_and_antonyms_chart = SynonymsAndAntonymsTest.chart_for(current_user)
  end

  def create
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.new(params[:synonyms_and_antonyms_test])
    @synonyms_and_antonyms_test.user = current_user

    if @synonyms_and_antonyms_test.save
      flash[:notice] = "Speed: #{@synonyms_and_antonyms_test.speed}, Accuracy #{@synonyms_and_antonyms_test.accuracy}%"
      redirect_to @synonyms_and_antonyms_test
    else
      render action: "new"
    end
  end

  def show
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.find(params[:id])
    @synonyms_and_antonyms_chart = SynonymsAndAntonymsTest.chart_for(current_user)
  end
end
