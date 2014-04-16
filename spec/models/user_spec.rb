require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'attributes' do
    before (:each) do
      @user = create(:user)
    end
    it 'has a name' do

      expect(@user.username).to eq ("John Doe")
    end
    it 'has an email' do
      expect(@user.email).to eq ("test@test.com")
    end
  end
end
