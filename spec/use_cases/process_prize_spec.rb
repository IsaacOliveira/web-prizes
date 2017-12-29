require 'rails_helper'

RSpec.describe ProcessPrize, type: :model do
  let(:subscription_double){ instance_double("Subscription", :id => 10)}

  describe '.initialize' do
    it 'initialize the ManageMatchedPrizeConditions with the subscription number' do
      expect(ManageMatchedPrizeConditions).to receive(:new).with(subscription_number: subscription_double.id)
      ProcessPrize.new(subscription: subscription_double)
    end
  end

  describe '#execute' do
    context 'the condition_matched_manager not returns a condition' do
      let(:condition_matched_manager_double){ instance_double("ManageMatchedPrizeConditions", :first_condition => nil)}
      it 'do nothing' do
        allow(ManageMatchedPrizeConditions).to receive(:new).and_return(condition_matched_manager_double)
        expect(subscription_double).not_to receive(:receive_prize!)
        ProcessPrize.new(subscription: subscription_double).execute
      end
    end

    context 'the condition_matched_manager returns a condition' do
      let(:prize_double){ instance_double(Prize) }
      let(:condition_double){ instance_double("PrizeCondition", :prize => prize_double) }

      let(:condition_matched_manager_double){ instance_double("ManageMatchedPrizeConditions", :first_condition => condition_double)}

      it 'allow the subscription to receive the prize' do
        allow(ManageMatchedPrizeConditions).to receive(:new).and_return(condition_matched_manager_double)
        allow(prize_double).to receive(:decrease_quantity!)
        expect(subscription_double).to receive(:receive_prize!).with(prize_double)

        ProcessPrize.new(subscription: subscription_double).execute
      end

      it 'decrease the quantity of the prize' do
        allow(ManageMatchedPrizeConditions).to receive(:new).and_return(condition_matched_manager_double)
        allow(subscription_double).to receive(:receive_prize!)
        expect(prize_double).to receive(:decrease_quantity!)

        ProcessPrize.new(subscription: subscription_double).execute
      end
    end
  end
end