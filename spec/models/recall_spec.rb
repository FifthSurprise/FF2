require 'spec_helper'


describe Recall do

  describe 'SM2 support' do
    before (:each) do
      @user = create(:user)
      @stack = @user.ownedstacks.create(name: "Gov Stack",
                                        description: "Prepare for your citizenship exam")

      @stack.owner = @user
      @stack.cards << create(:card)
      @recall = create(:recall)
    end

    it 'has recall data' do
      expect(@recall.easiness_factor).to eq(2.5)
      expect(@recall.number_repetitions).to eq(0)
      expect(@recall.quality_of_last_recall).to eq(nil)
      expect(@recall.repetition_interval).to eq(nil)
      expect(@recall.next_repetition).to eq(nil)
      expect(@recall.last_studied).to eq(nil)
    end

    it 'can process a recall result of 5' do
      @recall.process_recall_result(5)
      expect(@recall.easiness_factor).to eq(2.6)
      expect(@recall.quality_of_last_recall).to eq(5)
      expect(@recall.repetition_interval).to eq(1)
      expect(@recall.next_repetition).to eq(Date.today + 1)
      expect(@recall.last_studied).to eq(Date.today)
    end

    it 'can process a recall result of 2' do
      @recall.process_recall_result(2)
      expect(@recall.number_repetitions).to eq(0)
      expect(@recall.quality_of_last_recall).to eq(2)
      expect(@recall.repetition_interval).to eq(0)
    end
    it 'can process a recall result of 3' do
      @recall.process_recall_result(3)
      expect(@recall.repetition_interval).to eq(0)
    end

    it 'knows it has the right implemented methods for SM2' do
      expect{SM2.extended(@recall)}.to_not raise_error
      # expect{@recall.check_spaced_repetition_methods}.to_not raise_error
    end
  end
  
  # pending "add some examples to (or delete) #{__FILE__}"
end
