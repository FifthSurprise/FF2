class UsersController < ApplicationController
  def show
    @user = current_user if (params[:id].nil?)
    @user = User.find(params[:id]) if @user.nil?
    
    unless (current_user == @user)
      redirect_to @current_user
    end
    @user_stacks = []
    @user.stacks.each do |stack|
      @user_stacks.push(UserStack.where(user_id: @user.id, stack_id: stack.id).first)
    end
  end
end
