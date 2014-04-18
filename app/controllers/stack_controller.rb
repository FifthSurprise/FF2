class StackController < ApplicationController

  def new
    @stack = Stack.new
  end

  #create a stack
  def create
    @stack = Stack.new(stack_params)
  end

  #implement some params stuff
  private

  def stack_params

  end
end
