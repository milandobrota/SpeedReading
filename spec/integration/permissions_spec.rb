require './spec/spec_helper.rb'

describe 'Permissions' do
  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'When not logged in' do

    it 'should default to the sign in page' do
      visit '/'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect users url to the sign in page' do
      visit '/registered_users'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect contents url to the sign in page' do
      visit '/contents'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect word pairs url to the sign in page' do
      visit '/word_pairs'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect categories url to the sign in page' do
      visit '/categories'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect languages url to the sign in page' do
      visit '/languages'
      page.current_url.should =~ /sign_in/
    end

    it 'should reading speed test url to the sign in page' do
      visit '/reading_speed_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect flash reading test url to the sign in page' do
      visit '/flash_reading_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect flashing numbers test url to the sign in page' do
      visit '/flashing_numbers_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect flashing dots test url to the sign in page' do
      visit '/flashing_dots_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect scrambled word test url to the sign in page' do
      visit '/scrambled_word_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect word search test url to the sign in page' do
      visit '/word_search_tests/new'
      page.current_url.should =~ /sign_in/
    end

    it 'should redirect synonyms and antonyms test url to the sign in page' do
      visit '/synonyms_and_antonyms_tests/new'
      page.current_url.should =~ /sign_in/
    end
  end

  describe 'When logged in' do

    before :each do
      ensure_logged_in
    end

    it 'should be able to go to /registered_users when logged in' do
      visit '/registered_users'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /contents when logged in' do
      visit '/contents'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /word_pairs when logged in' do
      visit '/word_pairs'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /categories when logged in' do
      visit '/categories'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /languages when logged in' do
      visit '/languages'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /reading_speed_tests/new when logged in' do
      visit '/reading_speed_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /flash_reading_tests/new when logged in' do
      visit '/flash_reading_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /flashing_numbers_test when logged in' do
      visit '/flashing_numbers_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /flashing_dots_tests/new when logged in' do
      visit '/flashing_dots_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /scrambled_word_tests/new when logged in' do
      visit '/scrambled_word_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /word_search_tests/new when logged in' do
      visit '/word_search_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

    it 'should be able to go to /synonyms_and_antonyms_tests/new when logged in' do
      visit '/synonyms_and_antonyms_tests/new'
      page.current_url.should_not =~ /sign_in/
    end

  end

end
