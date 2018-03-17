class UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
    user_params = params.require(:user).permit(:name, :phone, :photo)
    user = current_user
    user.update(user_params)
    redirect_to user
  end

end
