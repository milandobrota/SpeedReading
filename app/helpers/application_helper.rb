module ApplicationHelper

  def user_header
    if current_user
      output = "Welcome #{current_user.name_or_email} | "
      output << link_to('Sign Out', destroy_user_session_path)
      output.html_safe
    else
      output = link_to('Sign in', new_user_session_path)
      output.html_safe
    end
  end

  def comprehension_rate_or_link_for(reading_test)
    return "#{reading_test.comprehension_rate}%" if reading_test.comprehension_rate
    return 'No comprehension test available' if reading_test.content.questions.empty?
    url = case reading_test
    when ReadingSpeedTest
      new_reading_speed_test_comprehension_test_path(reading_test)
    when ScrambledWordTest
      new_scrambled_word_test_comprehension_test_path(reading_test)
    end

    link_to('Take the test!', url)
  end

  def comprehension_test_path_for(reading_test)
    url = case reading_test
    when ReadingSpeedTest
      reading_speed_test_comprehension_tests_path(reading_test)
    when ScrambledWordTest
      scrambled_word_test_comprehension_tests_path(reading_test)
    end
    url
  end
end
