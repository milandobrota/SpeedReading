require './spec/spec_helper.rb'

describe 'Categories' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Category CRUD' do

    it 'should be editable' do
      ensure_logged_in_as 'admin'
      visit '/categories'
      click_on 'New'
      click_on 'Create Category'
      body.should =~ /Name can't be blank/
      fill_in 'Name', :with => 'Comedy'
      click_on 'Create Category'
      body.should =~ /Category was successfully created./
      body.should =~ /Comedy/
      click_on 'Back'
      sleep(1)
      body.should =~ /Comedy/
      find('.table-striped').click_on('Edit')
      fill_in 'Name', :with => 'Self-help'
      click_on 'Update Category'
      body.should =~ /Category was successfully updated./
      click_on 'Back'
      sleep(1)
      body.should =~ /Self-help/
      body.should_not =~ /Comedy/
      find('.table-striped').click_on('Destroy')
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      body.should =~ /Category was successfully deleted./
      body.should_not =~ /Self-help/
    end
  end

end
