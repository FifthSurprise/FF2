require 'spec_helper'

describe CardsController do
  before(:each)do
    @user = create(:user)
    @stack = create(:stack)
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

  it 'handles creating a new card in a stack' do
    post :create, stack_id:@stack.id, card:
      {question: "This is a question.", answer: "This is an answer"}
      # binding.pry
    expect(Card.last.question).to eq("This is a question.")
  end

end
