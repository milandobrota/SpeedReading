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
end
