module SessionsHelper

  # Save user id in session
  def log_in user
    session[:user_id] = user.id
    session[:admin] = true if current_user.admin?
  end

  # Log the current user out
  def log_out
    forget current_user
    session[:user_id] = nil
    session[:admin] = nil
  end

  # Check if there is an user currently logged in
  def logged_in?
    !current_user.nil?
  end

  # Get the current logged in user
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by_id user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by_id user_id
      if user && user.authenticate?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Return true if the given user is current user
  def current_user? user
    current_user == user
  end

  # Remember user in a persistent session
  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forget user in a persistent session
  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  # Check if current logged in user is admin or not
  def is_admin?
    session[:admin]
  end

  # Friendly redirect
  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Store current url as forwarding_url to redirect back
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
