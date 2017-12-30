module Admin::SessionsHelper

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:session_token)
    @current_user = nil
  end

  def load_session!
    redirect_to new_admin_session_path unless logged_in?
  end

end
