require './spec/spec_helper.rb'

describe 'Synonyms and Antonyms Test' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Synonyms and Antonyms Test' do

    before :all do
      @word_pair = WordPair.create!(:word_1 => 'Yes', :word_2 => 'Da', :synonyms => true)
    end

    it 'should work with the mouse' do
      ensure_logged_in_as 'member'
      visit '/synonyms_and_antonyms_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      find('#left_word_container').text.should == 'Yes'
      find('#right_word_container').text.should == 'Da'
      click_on 'Synonym'
      sleep(1)
      body.should =~ /Accuracy 100%/

      visit '/synonyms_and_antonyms_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      find('#left_word_container').text.should == 'Yes'
      find('#right_word_container').text.should == 'Da'
      click_on 'Antonym'
      sleep(1)
      body.should =~ /Accuracy 0%/
    end

    it 'should work with the mouse' do
      ensure_logged_in_as 'member'
      visit '/synonyms_and_antonyms_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      find('#left_word_container').text.should == 'Yes'
      find('#right_word_container').text.should == 'Da'
      find('body').native.send_keys :left
      sleep(1)
      body.should =~ /Accuracy 100%/

      visit '/synonyms_and_antonyms_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      find('#left_word_container').text.should == 'Yes'
      find('#right_word_container').text.should == 'Da'
      find('body').native.send_keys :right
      sleep(1)
      body.should =~ /Accuracy 0%/
    end

  end

end
