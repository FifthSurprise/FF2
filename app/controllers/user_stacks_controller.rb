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
        #what to do when adding a card?
        #add the cards
        current_user.save
        redirect_to "/users/#{current_user.id}",
          :notice => "Successfully started studying #{@stack.name}"
      end
    end
  end
end
