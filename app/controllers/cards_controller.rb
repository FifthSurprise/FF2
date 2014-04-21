class CardsController < ApplicationController

  def show
    @card = Card.find(params[:id])
  end

  def new
    @stack = Stack.find(params[:stack_id])
    @card = Card.new
  end

  def create
    binding.pry
    @stack = Stack.find(card_params[:stack_id])
    @card = @stack.cards.create(card_params)
    redirect_to stack_path(@stack)
  end

  private
  def card_params
    params.require(:card).permit(:question, :answer, :stack_id)
  end
end
