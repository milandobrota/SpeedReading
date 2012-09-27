require 'spec_helper'

describe ComprehensionTest do

  let(:question1) { Question.create!(:body => 'foo', :answers => %w(a b c d), :correct_answer => 1) }
  let(:question2) { Question.create!(:body => 'bar', :answers => %w(A B C D), :correct_answer => 2) }

  it 'should know how to calculate comprehension rate with integers' do
    reading_test = ReadingSpeedTest.create
    ComprehensionTest.check_user_answers(
      :reading_test => reading_test,
      :user_answers => {question1.id => question1.correct_answer}
    )
    reading_test.comprehension_rate.should == 100
  end

  it 'should know how to calculate comprehension rate with strings' do
    reading_test = ReadingSpeedTest.create
    ComprehensionTest.check_user_answers(
      :reading_test => reading_test,
      :user_answers => {question1.id.to_s => question1.correct_answer}
    )
    reading_test.comprehension_rate.should == 100
  end

  it 'should know how to calculate comprehension rate when wrong' do
    reading_test = ReadingSpeedTest.create
    ComprehensionTest.check_user_answers(
      :reading_test => reading_test,
      :user_answers => {question1.id => 2}
    )
    reading_test.comprehension_rate.should == 0
  end

  it 'should know how to calculate comprehension rate when partially wrong' do
    reading_test = ReadingSpeedTest.create
    ComprehensionTest.check_user_answers(
      :reading_test => reading_test,
      :user_answers => { question1.id => 2, question2.id => question2.correct_answer }
    )
    reading_test.comprehension_rate.should == 50
  end
end
