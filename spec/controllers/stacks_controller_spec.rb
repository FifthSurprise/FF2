require 'spec_helper'

describe StacksController do
  before(:each)do
    @user = create(:user)
    sign_in :user, @user
  end
  it 'handles renders a new stack' do
    sign_in :user, @user
    get :new
    expect(response).to render_template("new")
  end

  it 'handles creates a new stack' do
    post :create, stack:
      { name: 'StackName', description: 'SpecTest'}
      createstack = Stack.last
    expect(createstack.name).to eq('StackName')
    expect(createstack.owner).to eq(@user)
  end

  it 'handles improperly creating a new stack' do
    post :create, stack:
      {description: 'SpecTest'}
    response.should render_template :new 
  end

  it 'renders a show stack' do
    newstack = create(:stack)
    get :show, id: newstack
    response.should render_template :show
  end
end
