class UsersController < ApplicationController
  def show
    if current_user.photo.file?
      current_user.photo.url(:medium)
    else
      current_user.photo.options[:default_url]
    end
  end

  def edit
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to user
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :photo)
  end
end
