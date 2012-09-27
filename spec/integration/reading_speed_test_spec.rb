require './spec/spec_helper.rb'

describe 'Reading Speed Test' do

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
      visit '/reading_speed_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      body.should =~ /foo bar baz/
      click_on 'Done'
      test = ReadingSpeedTest.last
      body.should =~ /Your reading speed is #{test.wpm} wpm!/
      body.should =~ /No comprehension test available/

      question = Question.create!(:body => 'question text', :answers => ['foo', 'bar', 'baz', 'qux'], :correct_answer => 3)
      @content.questions << question
      @content.save!

      visit(current_url)
      click_on 'Take the test!'
      choose "user_answers_#{question.id}_3"
      click_on 'Finish'
      body.should =~ /100%/
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
      visit '/reading_speed_tests/new'
      click_on 'Select content'
      find('#content_name').text.should == 'Charlie the Unicorn'
      find('#content_credit').text.should == 'No source'
      select 'srpski', :from => 'language_select'
      select 'Novel', :from => 'category_select'
      find('.image_container .content_image').click
      find('#content_credit a').text.should == 'Djordje Balasevic'
      click_on 'Select this story!'
      click_on 'Start'
      sleep(5)
      find('#reading_text').text.should == 'Ovo je prica o Vasi Ladackom'
      click_on 'Done'
      body.should =~ /No comprehension test available/
    end

  end

end
