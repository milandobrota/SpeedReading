require 'spec_helper'

describe SynonymsAndAntonymsTest do

  let(:english) { Language.create!(:name => 'English') }
  let(:user) { User.create!(:email => 'milan@milandobrota.com', :password => 'foobar') }
  let(:content) { Content.create!(:name => 'Abc', :body => 'body', :language => english)}

  it 'should know how to setup for user with no previous tests' do
    test = SynonymsAndAntonymsTest.setup_for(user)
    test.user.should == user
  end

  it 'should know how to retrieve historical data for a user with no history' do
    SynonymsAndAntonymsTest.historical_data_for(user).should == {:speeds => [], :accuracies => [], :timestamps => []}
  end

  it 'should know how to retrieve historical data for a user' do
    start_timestamp = Time.zone.now.to_i * 1000
    SynonymsAndAntonymsTest.create!(:user => user, :speed => 140, :accuracy => 80)
    SynonymsAndAntonymsTest.create!(:user => user, :speed => 260, :accuracy => 90)
    end_timestamp = Time.zone.now.to_i * 1000
    historical_data = SynonymsAndAntonymsTest.historical_data_for(user)
    historical_data[:speeds].should == [140, 260]
    historical_data[:accuracies].should == [80, 90]
    historical_data[:timestamps].each do |timestamp|
      timestamp.should be >= start_timestamp
      timestamp.should be <= end_timestamp
    end
  end

end
