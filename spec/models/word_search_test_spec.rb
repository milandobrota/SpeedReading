require 'spec_helper'

describe WordSearchTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user' do
    content # force content creation
    test = WordSearchTest.setup_for(user)
    test.user.should == user
    test.content.should == content
    test.content.body[test.word].should_not be_nil
    test.word.size.should be > 0
    test.word.should_not =~ /\s+/
  end

  it 'should know how to retrieve historical data for a user with no history' do
    WordSearchTest.historical_data_for(user).should == {:scores => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    WordSearchTest.create!(:user => user, :score => 140, :content => content)
    WordSearchTest.create!(:user => user, :score => 260, :content => content)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = WordSearchTest.historical_data_for(user)
    historical_data[:scores].should == [140, 260]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
