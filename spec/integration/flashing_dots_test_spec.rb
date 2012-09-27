require './spec/spec_helper.rb'

describe 'Flashing Dots Test' do

  self.use_transactional_fixtures = false

  before :all do
    ensure_server_is_running
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  it 'should work with no setup' do
    ensure_logged_in_as 'member'
    visit '/flashing_dots_tests/new'
    click_on 'Start'
    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 1
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 1/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 1
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 2/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 1
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 3/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 1
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 4/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 1
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Level 2/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 2
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 1/

    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 2
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 2/

    # mess it up
    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 2
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots + 1
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Nope!\nThere was #{number_of_dots}/

    level = evaluate_script('FlashingDotsTest.level')
    level.should == 2

    #reload -> it should remember the previous test
    visit '/flashing_dots_tests/new'
    click_on 'Start'
    sleep(8) # wait for the countdown
    level = evaluate_script('FlashingDotsTest.level')
    level.should == 2
    body.should =~ /How many dots did you see?/
    number_of_dots = evaluate_script 'FlashingDotsTest.number_of_dots'
    number_of_dots.should be <= level + 4
    fill_in 'flashing_dots_input', :with => number_of_dots
    click_on 'OK'
    message = find('#flashing_dots_notice_container').text
    message.should =~ /Good job!\nCurrent streak: 1/
  end

end
