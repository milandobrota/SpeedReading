require 'spec_helper'

describe FlashingDotsTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user with no previous tests' do
    test = FlashingDotsTest.setup_for(user)
    test.user.should == user
    test.level.should == 0
  end

  it 'should know how to setup for user' do
    FlashingDotsTest.create!(:user => user, :level => 3)
    test = FlashingDotsTest.setup_for(user)
    test.user.should == user
    test.level.should == 3
  end

  it 'should know how to retrieve historical data for a user with no history' do
    FlashingDotsTest.historical_data_for(user).should == {:levels => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    FlashingDotsTest.create!(:user => user, :level => 3)
    FlashingDotsTest.create!(:user => user, :level => 4)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = FlashingDotsTest.historical_data_for(user)
    historical_data[:levels].should == [3, 4]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
