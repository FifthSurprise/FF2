class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless (current_user == @user)
      redirect_to @current_user
    end
    @user_stacks = []
    @user.stacks.each do |stack|
      @user_stacks.push(UserStack.where(user_id: @user.id, stack_id: stack.id).first)
    end
  end
end
