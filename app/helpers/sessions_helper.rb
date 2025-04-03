# Хелпер сессии
module SessionsHelper
  # Вход в систему
  def log_in(user)
    session[:user_id] = user.id
  end

  # Запомнить пользователя
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Прерывание запоминания пользователя
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Выход из системы
  def log_out
    forget(current_user) # Если пользователь был запомнен, то прерываем его запоминание
    session.delete(:user_id)
    @current_user = nil
  end

  # Возвращает текущего пользователя, если он вошел в систему
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Проверка, вошел ли пользователь
  def logged_in?
    !current_user.nil?
  end

  # Проверка, является ли текущий пользователь тем, кто передан в параметр
  def current_user?(user)
    user == current_user
  end

  # Прерывание запоминания пользователя
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Сохранение URL для перенаправления после логина
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # Перенаправление на сохраненный URL или на default
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
