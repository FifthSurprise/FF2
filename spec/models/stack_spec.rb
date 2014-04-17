require 'spec_helper'

describe Stack do
  describe 'attributes' do
    before(:each) do
      @user = create(:user)
      @stack = create(:stack)
      @user.stacks << @stack
      @stack.owner = @user
    end

    it 'has a name' do
      expect(@stack.name).to eq("Gov Stack")
    end

    it 'has a description' do
      expect(@stack.description).to eq("Prepare for your citizenship exam")
    end

    it 'has an owner' do
      @user.stacks.first.should eq (@stack)
      @stack.owner.should eq(@user)
    end
  end
end
