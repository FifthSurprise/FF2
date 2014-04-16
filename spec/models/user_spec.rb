require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'has a name' do
    user = create(:user)
    expect(user.username).to eq ("John Doe")
  end
end
