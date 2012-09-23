class WordPair < ActiveRecord::Base

  validates_presence_of :word_1, :word_2

  def relation
    synonyms ? 'synonyms' : 'antonyms'
  end

  def relation=(relation_type)
    self.synonyms = relation_type == 'synonyms'
  end
end
