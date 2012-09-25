require './spec/spec_helper.rb'

describe 'Registered users' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'User CRUD' do

    it 'should be editable' do
      ensure_logged_in_as 'admin'
      visit '/registered_users'
      body.should =~ /admin@test.com/
      click_on 'Edit'
      fill_in 'Email', :with => ''
      click_on 'Update User'
      body.should =~ /Email can't be blank/
      fill_in 'Email', :with => 'invalidemail'
      click_on 'Update User'
      body.should =~ /Email is invalid/
      fill_in 'Email', :with => 'validemail@test.com'
      click_on 'Update User'
      body.should =~ /User was successfully updated./
      body.should =~ /validemail@test.com/
    end

    it 'should be destroyable' do
      user = User.create!(:email => 'foo@bar.com', :password => 'foobar')
      ensure_logged_in_as 'admin'
      visit '/registered_users'
      body.should =~ /foo@bar.com/
      find(:xpath, "//a[@href='/registered_users/#{user.id}']").click
      page.driver.browser.switch_to.alert.accept
      body.should_not =~ /foo@bar.com/
    end
  end

end
