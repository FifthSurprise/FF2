require 'spec_helper'

describe CardsController do
  before(:each)do
    @user = create(:user)
    @stack = create(:stack)
    @card = create(:card)
    @stack.cards << @card

    sign_in :user, @user
  end

  it 'renders an individual card' do
    newstack = create(:stack)
    card = create(:card)
    newstack.cards << card

    get :show, id: card
    response.should render_template :show
  end

  it 'handles rendering a new card page' do
    sign_in :user, @user

    get :new, {:stack_id => @stack.id}
    expect(response).to render_template("new")
  end

  it 'handles creating a new card in a stack, routing back to the stack when done' do
    post :create, stack_id:@stack.id, card:
      {question: "This is a question.", answer: "This is an answer", stack_id: @stack.id}
    expect(Card.last.question).to eq("This is a question.")
    expect(Card.last.answer).to eq("This is an answer")
    response.should redirect_to "/stacks/#{@stack.id}"
  end

  describe 'destroying cards from a stack' do
    before(:each) do
      @stack.cards<< create(:card)
    end
    it 'can destroy a card from a stack' do
      card = @stack.cards.last
      count = @stack.cards.count
      delete :destroy, id: card
      expect(@stack.cards.count).to eq(count-1)
    end

    it 'removes all the recalls associated with the card' do
      @user.study_stack(@stack)
      card = @stack.cards.last
      recallcount = @user.recalls.count
      expect(recallcount).to_not eq(0)
      delete :destroy, id: card
      expect(Recall.where("card_id = #{card.id} and user_id = #{@user.id}").count).to eq(recallcount-1)
    end

    it 'removes recalls associated with a card for multiple users' do
      @user.study_stack(@stack)
      user2 = create(:user)
      user2.study_stack(@stack)

      card = @stack.cards.last
      recallcount = user2.recalls.count
      expect(recallcount).to_not eq(0)
      delete :destroy, id: card
      expect(Recall.where("card_id = #{card.id} and user_id = #{@user.id}").count).to eq(recallcount-1)
      expect(Recall.where("card_id = #{card.id} and user_id = #{user2.id}").count).to eq(recallcount-1)
    end
  end
end
