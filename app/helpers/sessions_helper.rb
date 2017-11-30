module SessionsHelper
  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user=(user)
    session[:user_id] = user.try(:id)
  end

  def store_target_location
    session[:return_to] = request.fullpath
  end

  def redirect_to_target_or_default(default, options = {})
    redirect_to(session[:return_to] || default, options)
    session[:return_to] = nil
  end

  def require_login
    unless logged_in?
      store_target_location
      redirect_to login_path
    end
  end
end
