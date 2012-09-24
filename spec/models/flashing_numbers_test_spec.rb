require 'spec_helper'

describe FlashingNumbersTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user with no previous tests' do
    test = FlashingNumbersTest.setup_for(user)
    test.user.should == user
    test.distance.should == 20
    test.number_of_digits.should == 1
  end

  it 'should know how to setup for user' do
    FlashingNumbersTest.create!(:user => user, :distance => 50, :number_of_digits => 4)
    test = FlashingNumbersTest.setup_for(user)
    test.user.should == user
    test.distance.should == 50
    test.number_of_digits.should == 4
  end

  it 'should know how to retrieve historical data for a user with no history' do
    FlashingNumbersTest.historical_data_for(user).should == {:distances => [], :numbers_of_digits => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    FlashingNumbersTest.create!(:user => user, :distance => 40, :number_of_digits => 2)
    FlashingNumbersTest.create!(:user => user, :distance => 60, :number_of_digits => 3)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = FlashingNumbersTest.historical_data_for(user)
    historical_data[:distances].should == [40, 60]
    historical_data[:numbers_of_digits].should == [2, 3]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
