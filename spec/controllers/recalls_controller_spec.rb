require 'spec_helper'

describe RecallsController do
  before (:each) do
    @user = create(:user)
    @stack = @user.ownedstacks.create(name: "Gov Stack",
                                      description: "Prepare for your citizenship exam")

    @stack.owner = @user
    @stack.cards << create(:card)
    @user.study_stack(@stack)
    @card = @stack.cards.last
    @recall = @user.recalls.last
  end

  it 'routes to the recall show page' do
    get :show, id: @recall.id
    response.should render_template :show
  end

  it 'will reset a recall' do
    pending
  end

  it 'will get a card to learn if there are any available' do
    pending
  end

  it 'will go back to user page if all cards are learned' do
    pending
  end

  it 'can process a recall quality' do
    pending
  end
end
