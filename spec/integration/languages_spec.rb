require './spec/spec_helper.rb'

describe 'Languages' do

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
      visit '/languages'
      click_on 'New'
      click_on 'Create Language'
      body.should =~ /Name can't be blank/
      fill_in 'Name', :with => 'English'
      click_on 'Create Language'
      body.should =~ /Language was successfully created./
      body.should =~ /English/
      click_on 'Back'
      sleep(1)
      body.should =~ /English/
      find('.table-striped').click_on('Edit')
      fill_in 'Name', :with => 'Srpski'
      click_on 'Update Language'
      body.should =~ /Language was successfully updated./
      click_on 'Back'
      sleep(1)
      body.should =~ /Srpski/
      body.should_not =~ /English/
      find('.table-striped').click_on('Destroy')
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      body.should =~ /Language was successfully deleted./
      body.should_not =~ /Srpski/
    end
  end

end
