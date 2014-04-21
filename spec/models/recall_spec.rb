require 'spec_helper'
require 'SM2'

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

    it 'should schedule next repetition for tomorrow if repetition_interval = 0 and quality_of_last_recall = 4' do
      @recall.process_recall_result(4)

      @recall.number_repetitions.should == 1
      @recall.repetition_interval.should == 1
      @recall.last_studied.should == Date.today
      @recall.next_repetition.should == (Date.today + 1)
      @recall.easiness_factor.should be_close(2.5, 0.01)
    end

    it 'should handle multi-repetitions' do
      @recall.process_recall_result(4)
      @recall.process_recall_result(4)
      @recall.process_recall_result(5)
      @recall.repetition_interval.should eq(15)
    end

    it 'should schedule next repetition for 6 days if repetition_interval = 1 and quality_of_last_recall = 4' do
      @recall.process_recall_result(4)
      @recall.process_recall_result(4)

      @recall.number_repetitions.should == 2
      @recall.repetition_interval.should == 6
      @recall.last_studied.should == Date.today
      @recall.next_repetition.should == (Date.today + 6)
      @recall.easiness_factor.should be_close(2.5, 0.01)
    end

    it 'should report as scheduled to recall (for today)' do
      @recall.next_repetition = Date.today
      @recall.scheduled_to_recall?.should == true

      @recall.next_repetition = Date.today - 1
      @recall.scheduled_to_recall?.should == true
    end

    it 'should not be scheduled to recall' do
      @recall.reset_spaced_repetition_data
      @recall.next_repetition = nil
      @recall.scheduled_to_recall?.should == true

      @recall.next_repetition = Date.today + 1
      @recall.scheduled_to_recall?.should == false

      @recall.next_repetition = Date.today + 99
      @recall.scheduled_to_recall?.should == false
    end

    it 'should require repeating items that scored 3' do
      @recall.process_recall_result(3)
      @recall.next_repetition.should == Date.today

      @recall.process_recall_result(3)
      @recall.next_repetition.should == Date.today

      @recall.process_recall_result(4)
      @recall.next_repetition.should == Date.today + 1
    end

  end
end
# pending "add some examples to (or delete) #{__FILEend
