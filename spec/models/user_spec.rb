require 'spec_helper'

describe User do
  describe 'attributes' do
    before (:each) do
      @user = create(:user)
      # @stack = @user.stacks.create(create(:stack))
      @stack = @user.ownedstacks.create(name: "Gov Stack",
                                        description: "Prepare for your citizenship exam")
      @stack.owner = @user
      
    end

    it 'has a name' do

      expect(@user.username).to eq ("John Doe")
    end

    it 'has an email' do
      expect(@user.email).to eq ("test@test.com")
    end

    it 'has a stack' do
      stack = @user.stacks.create(name: "Test Stack", description: "Stack for testing")
      expect(@user.stacks.last).to eq(stack)
    end

    it 'owns a stack' do
      @user.ownedstacks.first.should eq(@stack)
    end

    describe 'studying a stack' do
      it 'can have other stacks' do
        ownedstackcount = @user.ownedstacks.count

        user2 = create(:user)
        stack2 = user2.ownedstacks.create(name: "Gov Stack2",
                                          description: "Prepare for your citizenship exam2")
        @user.stacks << stack2
        @user.stacks.last.should eq(stack2)
        @user.ownedstacks.count.should eq(ownedstackcount)
      end

      it 'user can have a recall' do
        recallstack = @user.stacks.create(name: "Recall Stack", description: "Stack that is being studied")
        recallstack.cards <<(create(:card))
        expect(recallstack.cards.count).to eq(1)
      end

    end
  end
end
