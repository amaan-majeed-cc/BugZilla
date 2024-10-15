module ApplicationHelper
  def login_helper
    if current_user
      button_to "Logout", destroy_user_session_path, method: :delete, class: "btn btn-primary my-2 my-sm-0"
    else
      links =  link_to "Login", new_user_session_path, class: "btn btn-primary m-2 my-sm-0"
      links += link_to "Register", new_user_registration_path, class: "btn btn-primary m-2 my-sm-0"
      links.html_safe
    end
  end
end
