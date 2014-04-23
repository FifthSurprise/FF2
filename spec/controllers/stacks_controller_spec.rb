require 'spec_helper'

describe StacksController do
  before(:each)do
    @user = create(:user)
    sign_in :user, @user
  end

  it 'renders the index of all stacks' do
    get :index
    response.should render_template :index
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

  it 'can after update, goes to the stack' do
    newstack = create(:stack)
    post :update, id: newstack, stack:
      {description: 'SpecTest', 
        :name => "New Name"}
    expect(response).to redirect_to(newstack)
  end

  it 'will properly redirect with invalid stack' do
    post :gist, url:  "https://gist.giurprise/9663961"
    expect(response).to redirect_to (new_stack_path)
    flash[:alert].should eq('Need to submit with valid gist.')
    post :gist, url:  "https://gist.github.com/username/gistid"
    expect(response).to redirect_to (new_stack_path)
    flash[:alert].should eq('Need to submit with valid gist.')
  end


  it 'can load a stack from a gist' do
    expect(Stack.find_by(name: "Pokemon")).to eq(nil)
    post :gist, url:  "https://gist.github.com/FifthSurprise/9663961"

    resultstack = Stack.find_by(name: "Pokemon")
    expect(resultstack.name).to eq("Pokemon")
    expect(resultstack.owner).to eq(@user)
  end

end
