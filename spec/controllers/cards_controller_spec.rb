require 'spec_helper'

describe CardsController do
  before(:each)do
    @user = create(:user)
    sign_in :user, @user
  end
end
