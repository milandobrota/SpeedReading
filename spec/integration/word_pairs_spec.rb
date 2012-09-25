require './spec/spec_helper.rb'

describe 'Word pairs' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Word pair CRUD' do

    it 'should be editable' do
      ensure_logged_in_as 'admin'
      visit '/word_pairs'
      click_on 'New'
      click_on 'Create Word pair'
      body.should =~ /Word 1 can't be blank/
      body.should =~ /Word 2 can't be blank/
      fill_in 'Word 1', :with => 'Fast'
      fill_in 'Word 2', :with => 'Speedy'
      choose 'word_pair_relation_synonyms'
      click_on 'Create Word pair'
      body.should =~ /Word pair was successfully created./
      body.should =~ /Fast/
      body.should =~ /Speedy/
      body.should =~ /synonyms/
      click_on 'Back'
      sleep(1)
      body.should =~ /Fast/
      body.should =~ /Speedy/
      find('.table-striped').click_on('Edit')
      fill_in 'Word 1', :with => 'Up'
      fill_in 'Word 2', :with => 'Down'
      choose 'word_pair_relation_antonyms'
      click_on 'Update Word pair'
      body.should =~ /Word pair was successfully updated./
      click_on 'Back'
      sleep(1)
      body.should =~ /Up/
      body.should =~ /Down/
      body.should_not =~ /Fast/
      body.should_not =~ /Speedy/
      find('.table-striped').click_on('Destroy')
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      body.should =~ /Word pair was successfully deleted./
      body.should_not =~ /Up/
      body.should_not =~ /Down/
    end
  end

end
