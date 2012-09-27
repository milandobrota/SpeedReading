require './spec/spec_helper.rb'

describe 'Flash Reading Test' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Reading Test' do

    before :all do
      @english = Language.create!(:name => 'English')
      @srpski = Language.create!(:name => 'srpski')
      @novel = Category.create!(:name => 'Novel')
      @comedy = Category.create!(:name => 'Comedy')
      @content = Content.create!(
        :name => 'Charlie the Unicorn',
        :body => 'foo bar baz',
        :language => @english,
        :categories => [@comedy]
      )
    end

    it 'should work with no setup' do
      ensure_logged_in_as 'member'
      visit '/flash_reading_tests/new'
      click_on 'Start'
      sleep(6) # wait for the countdown
      body.should =~ /Your reading speed is/
    end

    it 'should work with selecting content' do
      ensure_logged_in_as 'member'
      another_content = Content.create!(
        :name => 'Vasa Ladacki',
        :body => 'Ovo je prica o Vasi Ladackom',
        :language => @srpski,
        :categories => [@novel],
        :source_name => 'Djordje Balasevic',
        :source_link => 'www.djb.com'
      )
      visit '/flash_reading_tests/new'
      click_on 'Select content'
      select 'srpski', :from => 'language_select'
      select 'Novel', :from => 'category_select'
      find('.image_container .content_image').click
      find('#content_credit a').text.should == 'Djordje Balasevic'
      click_on 'Select this story!'
      click_on 'Start'
      sleep(6)
      body.should =~ /Your reading speed is/
    end

  end

end
