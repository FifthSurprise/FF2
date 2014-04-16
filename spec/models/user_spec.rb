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

    it 'has a stack' do
      stack = @user.stacks.create(name: "Test Stack", description: "Stack for testing")
      expect(@user.stacks.last).to eq(stack)
    end
  end
end
