require 'spec_helper'

describe FlashReadingTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user' do
    content # forcing content creation
    test = FlashReadingTest.setup_for(user)
    test.user.should == user
    test.content.should == content
  end

  it 'should know how to retrieve historical data for a user with no history' do
    FlashReadingTest.historical_data_for(user).should == {:reading_speeds => [], :word_throughputs => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    FlashReadingTest.create!(:user => user, :word_throughput => 3, :reading_speed => 50)
    FlashReadingTest.create!(:user => user, :word_throughput => 4, :reading_speed => 60)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = FlashReadingTest.historical_data_for(user)
    historical_data[:reading_speeds].should == [50, 60]
    historical_data[:word_throughputs].should == [3, 4]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
