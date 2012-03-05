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
    reading_test.comprehension_rate.blank? ?
      link_to('Take the test!', new_reading_speed_test_comprehension_test_path(reading_test)) : "#{reading_test.comprehension_rate}%"
  end
end
