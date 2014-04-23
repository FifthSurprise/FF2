require 'spec_helper'
require 'application_helper'
describe 'Application Helper' do

  let(:dummy_class) { Class.new { include ApplicationHelper } }
  it 'should know what its gravatar url is' do
    user =  create(:user)
    user.update(email: "test@test.com")
    dummy_class.any_instance.stub(:root_url).and_return("http://localhost:3000")
    expect(dummy_class.new.avatar_for(user)).to eq("http://gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?s=100")
  end

  let(:dummy_class) { Class.new { include ApplicationHelper } }
  it 'should know what its mini-gravatar url is' do
    user =  create(:user)
    user.update(email: "test@test.com")
    dummy_class.any_instance.stub(:root_url).and_return("http://localhost:3000")
    expect(dummy_class.new.mini_avatar(user)).to eq("https://secure.gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?s=50")
  end

  let(:dummy_class) { Class.new { include ApplicationHelper } }
  it 'should test markdown method' do
    expect(dummy_class.new.markdown("This is *bongos*, indeed.")).to eq("<p>This is <em>bongos</em>, indeed.</p>\n")
  end
  let(:dummy_class) { Class.new { include ApplicationHelper } }

  it 'should test sanizating input' do
    text = '<a href="http://www.rubyonrails.org">Ruby on Rails</a>'
    expect(helper.sanitize(text)).to eq("Ruby on Rails\n")
  end

end
