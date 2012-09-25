require 'spec_helper'

describe WordPair do

  it 'should know if synonyms' do
    WordPair.new(:synonyms => true).relation.should == 'synonyms'
  end

  it 'should know if antonyms' do
    WordPair.new(:synonyms => false).relation.should == 'antonyms'
  end

  it 'should be able to set the synonym relation' do
    word_pair = WordPair.new
    word_pair.relation = 'synonyms'
    word_pair.relation.should == 'synonyms'
  end

  it 'should be able to set the antonym relation' do
    word_pair = WordPair.new
    word_pair.relation = 'antonyms'
    word_pair.relation.should == 'antonyms'
  end

end
