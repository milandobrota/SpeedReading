class SynonymsAndAntonymsTestsController < ApplicationController
  def new
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.setup_for(current_user)
  end

  def create
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.new(params[:synonyms_and_antonyms_tests])
    if @synonyms_and_antonyms_test.save
      redirect_to @synonyms_and_antonyms_test, notice: "Speed: #{@synonyms_and_antonyms_test.speed}, Accuracy #{@synonyms_and_antonyms_test.accuracy}%"
    else
      render action: "new"
    end
  end

  def show
    @synonyms_and_antonyms_test = SynonymsAndAntonymsTest.find(params[:id])
  end
end
