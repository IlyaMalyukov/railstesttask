class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Добро пожаловать на Rails Test Task!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :fullname, :email,
    :address, :city, :state, :country, :zip, :role,
    :password, :password_confirmation)
  end
end
