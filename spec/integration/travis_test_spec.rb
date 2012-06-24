require './spec/spec_helper.rb'

describe 'Travis' do
  it 'should run the test' do
    ensure_server_is_running
    visit '/'
    page.body.should =~ /Sign in/
  end
end
