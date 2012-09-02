class ComprehensionTest

  attr_accessor :reading_test

  def user_answer
  end
  
  def initialize(attr)
    super if attr.blank?
    @reading_test = attr[:reading_test]
    @user_answers       = attr[:user_answers] if attr[:user_answers]
  end

  def calculate_and_save_comprehension_rate
    calculate_comprehension_rate
    save_comprehension_rate
  end

  def calculate_comprehension_rate
    correct_answers = Question.find(@user_answers.keys).collect {|q| [q.id, q.correct_answer]}
    correct_answers = correct_answers.collect {|pair| pair.collect(&:to_s)}
    @comprehension_rate = ((correct_answers & @user_answers.to_a).size.to_f / correct_answers.size) * 100
  end

  def save_comprehension_rate
    @reading_test.update_attribute(:comprehension_rate, @comprehension_rate)
  end

  class << self
    def check_user_answers(params)
      new(
        :reading_test => params[:reading_test],
        :user_answers => params[:user_answers]
      ).calculate_and_save_comprehension_rate
    end
  end

end
