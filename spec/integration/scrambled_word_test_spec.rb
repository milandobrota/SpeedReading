require './spec/spec_helper.rb'

describe 'Scrambled Word Test' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Scrambled Word Test' do

    before :all do
      @english = Language.create!(:name => 'English')
      @srpski = Language.create!(:name => 'srpski')
      @novel = Category.create!(:name => 'Novel')
      @comedy = Category.create!(:name => 'Comedy')
      @content = Content.create!(
        :name => 'Charlie the Unicorn',
        :body => 'This test is nice',
        :language => @english,
        :categories => [@comedy]
      )
    end

    it 'should work with no setup' do
      ensure_logged_in_as 'member'
      visit '/scrambled_word_tests/new'
      click_on 'Start'
      sleep(5) # wait for the countdown
      find('#reading_text').text.should =~ /T[hi]+s t[es]+t is n[ic]+e/
      click_on 'Done'
      test = ScrambledWordTest.last
      body.should =~ /Your reading speed is #{test.wpm}/
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
      visit '/scrambled_word_tests/new'
      click_on 'Select content'
      select 'srpski', :from => 'language_select'
      select 'Novel', :from => 'category_select'
      find('.image_container .content_image').click
      find('#content_credit a').text.should == 'Djordje Balasevic'
      click_on 'Select this story!'
      click_on 'Start'
      sleep(5)
      find('#reading_text').text.should =~ /Ovo je p[ric]+a o V[as]+i L[adacko]+m/
      click_on 'Done'
      body.should =~ /No comprehension test available/
    end

  end

end
