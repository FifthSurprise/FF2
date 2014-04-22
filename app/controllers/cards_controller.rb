class CardsController < ApplicationController

  def show
    @card = Card.find(params[:id])
    @stack = @card.stack
    @studyingstack = !current_user.nil? && !current_user.studying?(@stack)
    @owned = (@stack.owner == current_user)
  end

  def new
    @stack = Stack.find(params[:stack_id])
    @card = Card.new
  end

  def create
    @stack = Stack.find(card_params[:stack_id])
    @card = @stack.cards.create(card_params)
    redirect_to stack_path(@stack)
  end

  def destroy
    @card = Card.find(params[:id])
    question = @card.question
    @stack = @card.stack
    @card.destroy
    #make sure that associated recalls are destroyed
    Recall.where("card_id = #{@card.id}").each{|recall| recall.destroy}
    redirect_to stack_path(@stack), notice: "Deleted #{question} from #{@stack.name}."
  end

  private
  def card_params
    params.require(:card).permit(:question, :answer, :stack_id)
  end
end
