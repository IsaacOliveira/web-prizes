module Admin::SessionsHelper

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:session_token)
    @current_user = nil
  end

end
