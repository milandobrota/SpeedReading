require 'spec_helper'

describe Content do

  let(:srpski) { Language.create(:name => 'srpski') }
  let(:english) { Language.create(:name => 'English') }
  let(:horror) { Category.create(:name => 'Horror') }
  let(:comedy) { Category.create(:name => 'Comedy') }

  it 'should be able to count words' do
    Content.new(:body => 'Charlie the Unicorn').word_count.should == 3
  end

  it 'should be able to count words with multiple spaces' do
    Content.new(:body => 'Charlie   the   Unicorn').word_count.should == 3
  end

  it 'should know the language name' do
    Content.new(:language => srpski).language_name.should == 'srpski'
  end

  it 'should know how to sort by name' do
    last = Content.create!(:name => 'foo', :body => 'foo', :language => srpski)
    first = Content.create!(:name => 'bar', :body => 'bar', :language => srpski)
    Content.sorted_by_name.should == [first, last]
  end

  it 'should know how to filter by category_id' do
    comedy_content = Content.create!(:name => 'foo', :body => 'foo', :language => srpski, :categories => [comedy])
    horror_content = Content.create!(:name => 'foo', :body => 'foo', :language => srpski, :categories => [horror])
    Content.filter(:category_id => comedy.id).should == [comedy_content]
  end

  it 'should know how to filter by language_id' do
    srpski_content = Content.create!(:name => 'foo', :body => 'foo', :language => srpski)
    english_content = Content.create!(:name => 'foo', :body => 'foo', :language => english)
    Content.filter(:language_id => english.id).should == [english_content]
  end
end
