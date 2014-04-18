class StackController < ApplicationController

  def new
    @stack = Stack.new
  end

  #create a stack
  def create
    @stack = Stack.new(book_params)
  end
end
