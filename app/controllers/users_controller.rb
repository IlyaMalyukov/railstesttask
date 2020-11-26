class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Пожалуйста, проверьте вашу электронную почту для активации аккаунта."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Профиль обновлён!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удалён"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:login, :fullname, :email,
    :address, :city, :state, :country, :zip, :role,
    :password, :password_confirmation)
  end

  # Предварительные фильтры

  # Подтверждает вход пользователя
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Пожалуйста, выполните вход!"
      redirect_to login_url
    end
  end

  # Подтверждает права пользователя.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
