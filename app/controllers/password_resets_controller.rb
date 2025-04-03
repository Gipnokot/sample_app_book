class PasswordResetsController < ApplicationController
  before_action :get_user,         only: %i[edit update]
  before_action :valid_user,       only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    # Находим пользователя по email
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    # Если пользователь найден, генерируем и отправляем email для сброса пароля
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit; end

  def update
    # Проверка, что пароль не пустой
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    # Если пароль не пустой, обновляем пользователя и логиним его
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = 'Password has been reset.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  # Параметры для обновления пароля
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Проверка, что пароль пустой
  def password_blank?
    params[:user][:password].blank?
  end

  # Получаем пользователя по email
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Проверка, что пользователь активирован и токен сброса пароля валиден
  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  # Проверка срока действия токена
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'Password reset has expired.'
    redirect_to new_password_reset_url
  end
end
