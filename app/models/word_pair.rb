class WordPair < ActiveRecord::Base

  def relation
    synonyms ? 'synonyms' : 'antonyms'
  end

  def relation=(relation_type)
    self.synonyms = relation_type == 'synonyms'
  end
end
