class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    current_user.follow params[:followed_id]
    @user = User.find params[:followed_id]
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end

  def destroy
    current_user.unfollow params[:followed_id]
    @user = User.find params[:followed_id]
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end
end
