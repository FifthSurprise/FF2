class RecallsController < ApplicationController
  #Show a specific card
  def show
    @recall = UserCard.find(params[:id])
    @user = @recall.user
    @stack = @recall.card.stack
    @card = @recall.card
  end

#learning a card
  def learn
    @user = User.find(params[:user])
    @user_stack = UserStack.find(params[:ustack])
    @stack = @user_stack.stack

    #get all the cards for that stack available to study

    #pick a random card or redirect

    @usercard = @user.user_cards.all.select{|c|c.card.stack == @stack && c.scheduled_to_recall?}.sample
    if @usercard.nil?
      respond_to do |format|
        format.html { redirect_to @user,:notice => "Finished Studying"}
      end
    else
      redirect_to user_stack_user_card_path(@user,@stack,@usercard)
    end
  end

  #Reset the card
  def reset
    @usercard = UserCard.find(params[:user_card_id])
    @user = @usercard.user
    @user_stack = UserStack.where(user_id: params[:user_id], stack_id: params[:stack_id]).first
    @card = @usercard.card
    @usercard.reset_spaced_repetition_data
    redirect_to user_stack_path(@user,@user_stack)
  end

  #Process a result
  def processQ
    @usercard = UserCard.find(params[:user_card_id])
    @user = @usercard.user
    @userstack = UserStack.where(user_id: params[:user_id], stack_id: params[:stack_id]).first
    @card = @usercard.card
    @usercard.process_recall_result(params[:val].to_i)
    redirect_to learn_path(@user,@userstack),
      :notice => %Q["#{@card.question}" processed with quality of #{@usercard.quality_of_last_recall}]
  end

end
