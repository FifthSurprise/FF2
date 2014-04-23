require 'spec_helper'

describe UserStacksController do
  describe 'When user is logged in' do
    before(:each)do
      @user = create(:user)
      user2 = create(:user)
      @stack = create(:stack)
      @stack.owner = user2
      sign_in :user, @user
    end

    it 'can show a user stack' do
      post :study_stack, id: @stack.id
      @user_stack = UserStack.where(user_id: @user.id, stack_id: @stack.id).first
      get :show, id: @user_stack.id
      expect(response).to render_template("show")
    end

    it 'can add a stack to be studied by a user' do
      post :study_stack, id: @stack.id
      flash[:notice].should eq("Successfully started studying #{@stack.name}")
      response.should redirect_to "/users/#{@user.id}"
      expect(@user.stacks).to include(@stack)
    end

    it 'will not add a stack being studied by a user already' do
      @user.stacks<<@stack
      count = @user.stacks.count
      post :study_stack, id: @stack.id
      flash[:notice].should eq("Already studying this stack.")
      response.should redirect_to @user
      expect(@user.stacks.count).to eq(count)
    end
  end

  describe 'When user is not logged in' do
    before(:each)do
      @stack = create(:stack)
    end
    it 'will not add a stack to be studied' do
      post :study_stack, id: @stack.id
      flash[:notice].should eq("Tried to do something weird with users")
      response.should redirect_to root_path
    end
  end
end
