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

  describe 'When logged in as member' do

    before :each do
      ensure_logged_in_as 'member'
    end

    it 'should not be able to go to /registered_users' do
      visit '/registered_users'
      page.current_url.should_not =~ /registered_users/
    end

    it 'should not be able to go to /contents' do
      visit '/contents'
      page.current_url.should_not =~ /contents/
    end

    it 'should not be able to go to /word_pairs' do
      visit '/word_pairs'
      page.current_url.should_not =~ /word_pairs/
    end

    it 'should not be able to go to /categories' do
      visit '/categories'
      page.current_url.should_not =~ /categories/
    end

    it 'should not be able to go to /languages' do
      visit '/languages'
      page.current_url.should_not =~ /languages/
    end

    it 'should be able to go to /reading_speed_tests/new' do
      visit '/reading_speed_tests/new'
      page.current_url.should =~ /reading_speed_tests\/new/
    end

    it 'should be able to go to /flash_reading_tests/new' do
      visit '/flash_reading_tests/new'
      page.current_url.should =~ /flash_reading_tests\/new/
    end

    it 'should be able to go to /flashing_numbers_test' do
      visit '/flashing_numbers_tests/new'
      page.current_url.should =~ /flashing_numbers_tests\/new/
    end

    it 'should be able to go to /flashing_dots_tests/new' do
      visit '/flashing_dots_tests/new'
      page.current_url.should =~ /flashing_dots_tests\/new/
    end

    it 'should be able to go to /scrambled_word_tests/new' do
      visit '/scrambled_word_tests/new'
      page.current_url.should =~ /scrambled_word_tests\/new/
    end

    it 'should be able to go to /word_search_tests/new' do
      visit '/word_search_tests/new'
      page.current_url.should =~ /word_search_tests\/new/
    end

    it 'should be able to go to /synonyms_and_antonyms_tests/new' do
      visit '/synonyms_and_antonyms_tests/new'
      page.current_url.should =~ /synonyms_and_antonyms_tests\/new/
    end

  end

  describe 'When logged in as admin' do

    before :each do
      ensure_logged_in_as 'admin'
    end

    it 'should be able to go to /registered_users' do
      visit '/registered_users'
      page.current_url.should =~ /registered_users/
    end

    it 'should be able to go to /contents' do
      visit '/contents'
      page.current_url.should =~ /contents/
    end

    it 'should be able to go to /word_pairs' do
      visit '/word_pairs'
      page.current_url.should =~ /word_pairs/
    end

    it 'should be able to go to /categories' do
      visit '/categories'
      page.current_url.should =~ /categories/
    end

    it 'should be able to go to /languages' do
      visit '/languages'
      page.current_url.should =~ /languages/
    end

    it 'should be able to go to /reading_speed_tests/new' do
      visit '/reading_speed_tests/new'
      page.current_url.should =~ /reading_speed_tests\/new/
    end

    it 'should be able to go to /flash_reading_tests/new' do
      visit '/flash_reading_tests/new'
      page.current_url.should =~ /flash_reading_tests\/new/
    end

    it 'should be able to go to /flashing_numbers_test' do
      visit '/flashing_numbers_tests/new'
      page.current_url.should =~ /flashing_numbers_tests\/new/
    end

    it 'should be able to go to /flashing_dots_tests/new' do
      visit '/flashing_dots_tests/new'
      page.current_url.should =~ /flashing_dots_tests\/new/
    end

    it 'should be able to go to /scrambled_word_tests/new' do
      visit '/scrambled_word_tests/new'
      page.current_url.should =~ /scrambled_word_tests\/new/
    end

    it 'should be able to go to /word_search_tests/new' do
      visit '/word_search_tests/new'
      page.current_url.should =~ /word_search_tests\/new/
    end

    it 'should be able to go to /synonyms_and_antonyms_tests/new' do
      visit '/synonyms_and_antonyms_tests/new'
      page.current_url.should =~ /synonyms_and_antonyms_tests/
    end

  end

end
