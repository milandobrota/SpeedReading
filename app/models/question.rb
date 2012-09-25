class Question < ActiveRecord::Base
  serialize :answers, Array

  validates_presence_of :correct_answer, :body

  belongs_to :content
end
