require 'rails_helper'

RSpec.describe PrizeConditionsChecker, type: :model do

  describe '.initialize' do

    it 'gets the conditions from the repository' do
      expect(PrizeConditionRepository).to receive(:with_prize_available)
      PrizeConditionsChecker.new(subscription_number: 1)
    end
  end

  describe '#get_all_match_conditions' do
    let(:subscription_number){ 10 }
    let(:condition_double_matched){ instance_double("PrizeCondition", :matches_all_rules? => true) }
    let(:condition_double_not_matched){ instance_double("PrizeCondition", :matches_all_rules? => false) }
    let(:condition_double_overlapped){ instance_double(PrizeCondition) }

    let(:conditions_list){ [condition_double_matched, condition_double_not_matched] }

    it 'calls matches_all_rules? with subscription_number for all conditions' do
      allow(PrizeConditionRepository).to receive(:with_prize_available).and_return(conditions_list)
      expect(condition_double_matched).to receive(:matches_all_rules?).with(subscription_number)
      expect(condition_double_not_matched).to receive(:matches_all_rules?).with(subscription_number)
      PrizeConditionsChecker.new(subscription_number: subscription_number).get_all_match_conditions
    end

    context "with a overlapped condition" do
      before do
        allow(PrizeConditionRepository).to receive(:with_prize_available).and_return(conditions_list)
        allow(PrizeConditionRepository).to receive(:get_overlapped).and_return([condition_double_overlapped])
      end

      it 'returns the array of matched conditions with overlapped conditions in the beginning' do
        conditions = PrizeConditionsChecker.new(subscription_number: subscription_number).get_all_match_conditions
        expect(conditions).to match_array([condition_double_overlapped, condition_double_matched])
        expect(conditions.first).to be == condition_double_overlapped
        expect(conditions.last).to be == condition_double_matched
      end
    end

    context "without overlapped conditions" do
      before do
        allow(PrizeConditionRepository).to receive(:with_prize_available).and_return(conditions_list)
        allow(PrizeConditionRepository).to receive(:get_overlapped).and_return([])
      end

      it 'returns the array of matched conditions' do
        conditions = PrizeConditionsChecker.new(subscription_number: subscription_number).get_all_match_conditions
        expect(conditions).to match_array([condition_double_matched])
      end
    end
  end
end