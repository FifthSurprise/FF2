class StacksController < ApplicationController

  def show
    @stack = Stack.find(params[:id])
  end

  def new
    @stack = Stack.new
  end

  #create a stack
  def create
    @stack = Stack.new(stack_params)
    @stack.owner = current_user
    respond_to do |format|
      if @stack.save
        format.html { redirect_to @stack, notice: 'Stack was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stack }
      else
        format.html { render action: 'new' }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @stack = Stack.find(params[:id])
  end


  private
  #implement strong pramas stuff
  def stack_params
    params.require(:stack).permit(:name, :description, :owner_id)
  end
end
