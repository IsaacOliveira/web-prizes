require 'rails_helper'

RSpec.describe ManageMatchedPrizeConditions, type: :model do

  describe '.initialize' do
    it 'initializes the prizes conditions checker with subscription number' do
      expect(PrizeConditionsChecker).to receive(:new).with(subscription_number: 1)
      PrizeConditionsChecker.new(subscription_number: 1)
    end
  end

  describe '#first_condition' do
    let(:prize_conditions_checker_double){ instance_double(PrizeConditionsChecker) }
    let(:condition_double_first){ instance_double(PrizeCondition) }
    let(:condition_double_second){ instance_double(PrizeCondition) }
    let(:condition_double_third){ instance_double(PrizeCondition) }
    let(:conditions_list){ [condition_double_first, condition_double_second, condition_double_third] }

    it 'gets the matched conditions from condition checker' do
      allow(PrizeConditionsChecker).to receive(:new).and_return(prize_conditions_checker_double)
      expect(prize_conditions_checker_double).to receive(:get_all_match_conditions).and_return(conditions_list)
      allow(PrizeConditionRepository).to receive(:set_overlapped)
      allow(PrizeConditionRepository).to receive(:set_not_overlapped)
      ManageMatchedPrizeConditions.new(subscription_number: 1).first_condition
    end

    it 'sets the first condition as not overlapped' do
      allow(PrizeConditionsChecker).to receive(:new).and_return(prize_conditions_checker_double)
      allow(prize_conditions_checker_double).to receive(:get_all_match_conditions).and_return(conditions_list)
      allow(PrizeConditionRepository).to receive(:set_overlapped)
      expect(PrizeConditionRepository).to receive(:set_not_overlapped).with([condition_double_first])

      ManageMatchedPrizeConditions.new(subscription_number: 1).first_condition
    end

    it 'sets the other conditions as overlapped' do
      allow(PrizeConditionsChecker).to receive(:new).and_return(prize_conditions_checker_double)
      allow(prize_conditions_checker_double).to receive(:get_all_match_conditions).and_return(conditions_list)
      allow(PrizeConditionRepository).to receive(:set_not_overlapped)
      expect(PrizeConditionRepository).to receive(:set_overlapped).with([condition_double_second, condition_double_third])

      ManageMatchedPrizeConditions.new(subscription_number: 1).first_condition
    end

    it 'returns the first condition' do
      allow(PrizeConditionsChecker).to receive(:new).and_return(prize_conditions_checker_double)
      allow(prize_conditions_checker_double).to receive(:get_all_match_conditions).and_return(conditions_list)
      allow(PrizeConditionRepository).to receive(:set_overlapped)
      allow(PrizeConditionRepository).to receive(:set_not_overlapped)

      condition = ManageMatchedPrizeConditions.new(subscription_number: 1).first_condition
      expect(condition).to be == condition_double_first
    end
  end

end