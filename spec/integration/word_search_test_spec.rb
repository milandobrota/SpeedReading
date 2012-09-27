require './spec/spec_helper.rb'

describe 'Word Search Test' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Word Search Test' do

    before :all do
      @english = Language.create!(:name => 'English')
      @srpski = Language.create!(:name => 'srpski')
      @novel = Category.create!(:name => 'Novel')
      @comedy = Category.create!(:name => 'Comedy')
      @content = Content.create!(
        :name => 'Charlie the Unicorn',
        :body => 'Word search test is awesome',
        :language => @english,
        :categories => [@comedy]
      )
    end

    it 'should work with no setup' do
      ensure_logged_in_as 'member'
      visit '/word_search_tests/new'
      click_on 'Start'
      sleep(10) # wait for the countdown
      correct_word = evaluate_script 'WordSearchTest.word'
      wrong_word = (@content.body.split - [correct_word]).first
      message = find('.clickable', :text => wrong_word).click
      message.should == 'Try again'
      page.driver.browser.switch_to.alert.accept
      message = find('.clickable', :text => correct_word).click
      message.should =~ /Good job/
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      body.should =~ /Your score is #{WordSearchTest.last.score}/
    end

  end

end
