require 'spec_helper'

describe ScrambledWordTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user with no previous tests' do
    content # force content creation
    test = ScrambledWordTest.setup_for(user)
    test.user.should == user
    test.content.should == content
  end

  it 'should know how to retrieve historical data for a user with no history' do
    ScrambledWordTest.historical_data_for(user).should == {:reading_speeds => [], :comprehension_rates => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    ScrambledWordTest.create!(:user => user, :wpm => 140, :comprehension_rate => 80, :content => content)
    ScrambledWordTest.create!(:user => user, :wpm => 260, :comprehension_rate => 90, :content => content)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = ScrambledWordTest.historical_data_for(user)
    historical_data[:reading_speeds].should == [140, 260]
    historical_data[:comprehension_rates].should == [80, 90]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
