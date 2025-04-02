class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :store_location, only: [ :edit, :update ]
  before_action :correct_user,   only: [ :edit, :update ]
  before_action :admin_user,     only: :destroy

  def index
      @users = User.paginate(page: params[:page], per_page: 30)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
    redirect_to root_url unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    if logged_in?
      @user = User.find(params[:id])
    else
      store_location
      redirect_to login_url
    end
  end

  def update
    if @user.update(user_params)
      redirect_back_or @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def friendly_forwarding
      if session[:forwarding_url]
        redirect_to session[:forwarding_url]
        session.delete(:forwarding_url)
      end
    end
end
