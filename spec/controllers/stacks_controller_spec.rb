require 'spec_helper'

describe StacksController do
  before(:each)do
    @user = create(:user)
    sign_in :user, @user
  end

  it 'renders a show stack' do
    newstack = create(:stack)
    get :show, id: newstack
    response.should render_template :show
  end

  it 'renders a new stack page' do
    sign_in :user, @user
    get :new
    expect(response).to render_template("new")
  end

  it 'handles creating a new stack' do
    post :create, stack:
      { name: 'StackName', description: 'SpecTest'}
    createstack = Stack.last
    expect(controller.params[:stack][:name]).to eq('StackName')
    expect(createstack.name).to eq('StackName')
    expect(createstack.owner).to eq(@user)
  end

  it 'handles improperly creating a new stack' do
    post :create, stack:
      {description: 'SpecTest'}
    response.should render_template :new
  end

  it 'renders an edit stack page' do
    newstack = create(:stack)
    sign_in :user, @user
    get :edit, id: newstack
    expect(response).to render_template("edit")
  end

end
