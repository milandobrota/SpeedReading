require './spec/spec_helper.rb'

describe 'Contents' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
    @english = Language.create!(:name => 'English')
    @content = Content.create!(:name => 'Title', :body => 'Short text', :language => @english)
  end

  after :all do
    DatabaseCleaner.clean
  end

  it 'should be editable' do
    ensure_logged_in_as 'admin'
    visit '/contents'
    body.should =~ /Text/
    click_on 'Edit'
    fill_in 'Name', :with => ''
    click_on 'Update Content'
    body.should =~ /Name can't be blank/
    fill_in 'Body', :with => ''
    click_on 'Update Content'
    body.should =~ /Body can't be blank/
    fill_in 'Name', :with => 'New Title'
    fill_in 'Body', :with => 'Long ' * 150 + 'Text'
    click_on 'Update Content'
    body.should =~ /Content was successfully updated./
    body.should =~ /New Title/
    content_body = find("#content_body").text
    content_body.should =~ /Long/
    content_body.should_not =~ /Text/ # shortened
    click_on 'more'
    content_body = find("#content_body").text
    content_body.should =~ /Text/ # expanded
    click_on 'Add questions'
    click_on 'Create Question'
    body.should =~ /Body can't be blank/
    body.should =~ /Correct answer can't be blank/
    fill_in 'Body', :with => 'Question text'
    fill_in 'answer_a', :with => 'Answer A'
    fill_in 'answer_b', :with => 'Answer B'
    fill_in 'answer_c', :with => 'Answer C'
    fill_in 'answer_d', :with => 'Answer D'
    choose 'question_correct_answer_0' # A
    click_on 'Create Question'
    body.should =~ /Question was successfully created./
    click_on 'Back'
    sleep(1)
    body.should =~ /Question text/
    find(".table-striped").click_on('Edit')
    fill_in 'Body', :with => 'New question text'
    click_on 'Update Question'
    body.should =~ /Question was successfully updated./
    click_on 'Back'
    sleep(1)
    body.should =~ /New question text/
    find(".table-striped").click_on('Destroy')
    page.driver.browser.switch_to.alert.accept
    body.should_not =~ /New question text/
    click_on 'Destroy'
    page.driver.browser.switch_to.alert.accept
    page.should_not =~ /New Title/
  end

end
