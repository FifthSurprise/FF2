class RecallsController < ApplicationController
  #Show a specific card
  def show
    @recall = Recall.find(params[:id])
    @user = @recall.user
    @stack = @recall.stack
    @card = @recall.card
  end

  #learning a card
  def learn
    @user = User.find(params[:user])
    stack = params[:stack]

    #pick a random card or redirect
    @nextrecall = @user.get_stack_recalls(stack).sample
    if @nextrecall.nil?
      respond_to do |format|
        format.html { redirect_to @user,:notice => "Finished Studying Stack"}
      end
    else
      #redirect to the card
      redirect_to recall_path(@nextrecall)
      # redirect_to user_stack_user_card_path(@user,@stack,@usercard)
    end
  end

  #Reset the card
  def reset
    @recall = Recall.find(params[:id])
    # @user = @usercard.user
    @user = @recall.user
    @stack = @recall.stack
    @card = @recall.card
    @recall.reset_spaced_repetition_data
    redirect_to recall_path(@recall), :notice => "Card was reset."
  end

  #Process a result
  def processQ
    @recall = Recall.find(params[:id])
    @user = @recall.user
    @stack = @recall.card.stack
    @card = @recall.card
    @recall.process_recall_result(params[:val].to_i)
    redirect_to learn_path(@user,@stack),
    :notice => %Q["#{@card.question}" processed with quality of #{@recall.quality_of_last_recall}]
  end

end
