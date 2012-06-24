require './spec/spec_helper.rb'

describe 'Travis' do
  it 'should run the test' do
    visit 'http://google.com'
    page.body.should =~ /Documents/
  end
end
