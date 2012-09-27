require './spec/spec_helper.rb'

describe 'Flashing Numbers Test' do

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
      visit '/flashing_numbers_tests/new'
      click_on 'Start'
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 20
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      body.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 100
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 180
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 260
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 340
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 420
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 500
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 580
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 660
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 740
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 820
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 900
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 1
      right.to_s.size.should == 1
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /It's time to increase the digits!/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 80
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 2
      right.to_s.size.should == 2
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      find('#flashing_numbers_notice_container').text.should =~ /Good job! Let's increase the distance/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 160
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 2
      right.to_s.size.should == 2
      fill_in 'flashing_numbers_input_left', :with => left + 1
      fill_in 'flashing_numbers_input_right', :with => right + 1
      click_on 'OK'
      body.should =~ /Try again/
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 80
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 2
      right.to_s.size.should == 2
      fill_in 'flashing_numbers_input_left', :with => left
      fill_in 'flashing_numbers_input_right', :with => right
      click_on 'OK'
      evaluate_script('FlashingNumbersTest.inner_width').should == 160

      # reload and it will remember the level
      visit '/flashing_numbers_tests/new'
      click_on 'Start'
      sleep(8) # wait for the countdown
      evaluate_script('FlashingNumbersTest.inner_width').should == 160
      body.should =~ /What numbers did you see?/
      left = evaluate_script 'FlashingNumbersTest.left'
      right = evaluate_script 'FlashingNumbersTest.right'
      left.to_s.size.should == 2
      right.to_s.size.should == 2
    end

  end

end
