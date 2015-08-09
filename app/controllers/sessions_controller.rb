class SessionsController < ApplicationController
  before_action :guest_user, only: [:new, :create]
  before_action :logged_in_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by_email params[:email].downcase
    if user && user.authenticate(params[:password])
      log_in user
      params[:remember] == '1' ? remember(user) : forget(user)
      flash[:success] = t :success_login
      default_link = is_admin? ? admin_url : root_url
      redirect_back_or default_link
    else
      flash.now[:danger] = t :fail_login
      render "new"
    end
  end

  def destroy
    log_out
    flash[:success] = t :logged_out
    redirect_to root_url
  end

  private
  # Only allow guest user to login
  def guest_user
    if logged_in?
      flash[:info] = t :logged_in
      redirect_back_or root_url
    end
  end
end
