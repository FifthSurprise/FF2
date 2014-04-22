class StacksController < ApplicationController

  def index
    @stacks = Stack.all
  end

  def show
    @stack = Stack.find(params[:id])
    @studyingstack = !current_user.nil? && !current_user.studying?(@stack)
    @owned = (@stack.owner == current_user)
  end

  def new
    @stack = Stack.new
  end

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

  def update
    @stack = Stack.find(params[:id])
    @stack.update(stack_params)
    redirect_to @stack
  end

  def gist
    url = params[:url]
    if url == "https://gist.github.com/username/gistid"
      redirect_to new_stack_path, alert: 'Need to submit with valid gist.'
    else
      begin
        s = Stack.parseGist(url)
        s.owner = current_user
        s.save
        redirect_to s, notice: "Successfully saved #{s.name}."
      rescue
      redirect_to new_stack_path, alert: 'Need to submit with valid gist.'
      end
    end
  end

  private
  #implement strong params stuff
  def stack_params
    params.require(:stack).permit(:name, :description, :owner_id)
  end
end
