class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless (current_user == @user)
      redirect_to @current_user
    end
  end
end
