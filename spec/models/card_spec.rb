require 'spec_helper'

describe Card do
  describe 'attributes' do
    before(:each) do
      @card = create(:card)
      @stack = create(:stack)
      @stack.cards << @card
    end
    it 'has a question' do
      expect(@card.question).to eq("Where does the President live?")
    end
    it 'has an answer' do
      expect(@card.answer).to eq("The White House")
    end

    it 'belongs to a stack' do
    end
  end
end
