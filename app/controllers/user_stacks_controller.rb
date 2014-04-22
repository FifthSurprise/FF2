class UserStacksController < ApplicationController

  def study_stack
    #current_user is the user
    if current_user.nil?
      redirect_to root_path, :notice =>"Tried to do something weird with users"
    else
      @stack = Stack.find(params[:id])
      if current_user.stacks.include?(@stack)
        redirect_to current_user, :notice =>"Already studying this stack."
      else
        current_user.study_stack(@stack)
        current_user.save
        redirect_to "/users/#{current_user.id}",
          :notice => "Successfully started studying #{@stack.name}"
      end
    end
  end

  #shows details of the stack getting studied
  def show
    @user_stack = UserStack.find(params[:id])
    @stack = @user_stack.stack
    @user = @user_stack.user
    @recalls = @user.get_stack_recalls(@stack)
    @studyrecalls = @user.get_stack_studyable_recalls(@stack)
  end
end
