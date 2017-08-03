class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def require_authentication!
    unless current_user
      flash[:danger] = 'Please log in!'
      redirect_to new_sessions_path
    end
  end

  def require_no_authentication!
    if current_user
      flash[:danger] = 'You are already logged in!'
      redirect_back fallback_location: root_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

  helper_method :current_user
end
