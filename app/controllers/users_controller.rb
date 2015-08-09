class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.all.order created_at: :desc
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = "Your account is successfully created."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t :update_user
      redirect_back_or @user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def load_user
    @user = User.find params[:id]
  end
end
