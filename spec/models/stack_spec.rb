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

  describe 'relation actions' do
    before(:each) do
      @user = create(:user)
      @stack = create(:stack)
      @stack.owner = @user
      @stack.cards << create(:card)
      @stack.cards << create(:card)
      @user.study_stack(@stack)
    end

    it 'can destroy all associated cards' do
      stackcount = @user.stacks.count
      stackcardcount = @stack.cards.count
      userrecallcount = @user.recalls.count
      @stack.emptycards
      expect(@user.stacks.count).to eq(stackcount)
      expect(@stack.cards.count).to eq(0)
      expect(@user.recalls.count).to eq(userrecallcount - stackcardcount)

    end
  end
end
