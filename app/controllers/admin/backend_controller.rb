class Admin::BackendController < ApplicationController
  before_action :logged_in_user
  before_action :admin

  private
  # Before filter: Ensure that current user is admin
  def admin
    unless is_admin?
      flash[:danger] = t :not_authorized
      redirect_to request.referrer || root_path
    end
  end
end
