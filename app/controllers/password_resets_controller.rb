class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(
      email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "На электронную почту отправлена инструкция по восстановлению пароля"
      redirect_to root_url
    else
      flash.now[:danger] = "Такой почты не найдено"
      render 'new'
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash.now[:danger] = "Пароль не может быть пустым"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Пароль восстановлен."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def get_user
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Возвращает true, если пароль пустой.
  def password_blank?
    params[:user][:password].blank?
  end

  # Предварительные фильтры

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Подтверждает допустимость пользователя.
  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Проверяет срок действия токена.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Срок действия сброса пароля истёк."
      redirect_to new_password_reset_url
    end
  end
end
