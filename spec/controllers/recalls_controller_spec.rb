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
    get :show, id: @recall
    response.should render_template :show
  end

  it 'will reset a recall' do
    @recall.process_recall_result(4)
    @recall.process_recall_result(4)
    @recall.process_recall_result(5)
    @recall.repetition_interval.should eq(15)
    @recall.reset
    post :reset, id: @recall
    @recall.number_repetitions.should eq(0)
  end

  it 'will get a card to learn if there are any available' do
    get :learn, user: @user, stack: @stack
    response.should redirect_to (recall_path(@recall))

  end

  it 'will go back to user page if all cards are learned' do
    @recall.process_recall_result(4)
    @recall.process_recall_result(4)
    @recall.process_recall_result(5)
    get :learn, user: @user, stack: @stack
    response.should redirect_to (@user)
  end

  it 'can process a recall quality' do
    post :processQ, id: @recall, val: 4
    post :processQ, id: @recall, val: 4
    post :processQ, id: @recall, val: 5
    @recall.reload
    @recall.repetition_interval.should eq(15)
  end
end
