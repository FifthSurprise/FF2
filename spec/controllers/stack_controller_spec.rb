require 'spec_helper'

describe StackController do
  it 'Handles creating a new stack' do
    get :new
    expect(response).to render_template("new")
  end
end
