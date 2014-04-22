require 'spec_helper'

describe User do
  describe 'attributes' do
    before (:each) do
      @user = create(:user)
      @stack = @user.ownedstacks.create(name: "Gov Stack",
                                        description: "Prepare for your citizenship exam")
      @stack.owner = @user

    end

    it 'has an email' do
      @user.email = "test14@test.com"
      expect(@user.email).to eq ("test14@test.com")
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


      it 'can tell if it is studying a stack' do
        expect(@user.studying?(@stack)).to eq(false)
        @user.study_stack(@stack)
        expect(@user.studying?(@stack)).to eq(true)
      end

      it 'user can have a recall' do
        recallstack = create(:stack)
        studycard = (create(:card))
        recallstack.cards << studycard
        @user.study_stack(recallstack)

        expect(recallstack.cards.count).to eq(1)
        expect(recallstack.cards.first).to eq (studycard)
        recall = (Recall.where("user_id = #{@user.id}").where("card_id = #{studycard.id}")).first
        expect(recall.easiness_factor).to eq (2.5)
      end

    end
  end
end
