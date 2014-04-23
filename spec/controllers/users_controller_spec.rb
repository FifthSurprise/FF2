require 'spec_helper'

describe UsersController do
  before(:each)do
        @user = create(:user)
    @stack = create(:stack)
    @stack.owner = @user
    @stack.cards << create(:card)
    @user.study_stack(@stack)
    sign_in :user, @user
  end
  it 'renders the show page' do
    get :show, id: @user
    response.should render_template :show
  end
  it 'does not render someone else\'s page' do
    user2 = create(:user)
    get :show, id: user2
    response.should redirect_to @user

  end
end
