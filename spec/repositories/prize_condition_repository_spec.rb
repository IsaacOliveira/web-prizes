require 'rails_helper'

RSpec.describe PrizeConditionRepository, type: :model do

  describe '.with_prize_available' do
    context 'with one condition with prize that has quantity and other that has not' do
      let(:prize_with_quantity){ Prize.create(name: "Prize With quantity", quantity: 10) }
      let!(:prize_condition_with_quantity){ PrizeCondition.create(name: "Test Rule", rules: [], prize: prize_with_quantity ) }
      let(:prize_without_quantity){ Prize.create(name: "Prize Without quantity", quantity: 0) }
      let!(:prize_condition_without_quantity){ PrizeCondition.create(name: "Test Rule", rules: [], prize: prize_without_quantity ) }

      it 'return the prize condition that the prize has quantity left' do
        expect(PrizeConditionRepository.with_prize_available).to contain_exactly(prize_condition_with_quantity)
      end
    end
  end

  describe '.get_overlapped' do

    context 'with two overlapped conditions and one not overlapped' do
      let(:prize){ Prize.create(name: "Test Prize", quantity: 10) }
      let!(:prize_first_condition_overlapped){ PrizeCondition.create(name: "Test Rule1", rules: [], overlapped: true, prize: prize ) }
      let!(:prize_second_condition_overlapped){ PrizeCondition.create(name: "Test Rule2", rules: [], overlapped: true, prize: prize ) }
      let!(:prize_condition_not_overlapped){ PrizeCondition.create(name: "Test Rule3", rules: [], prize: prize ) }

      it 'return the first overlapped condition' do
        expect(PrizeConditionRepository.get_overlapped).to be == prize_first_condition_overlapped
      end
    end
  end

  describe '.set_not_overlapped' do
    let(:prize){ Prize.create(name: "Test Prize", quantity: 10) }
    let(:prize_condition_overlapped){ PrizeCondition.create(name: "Test Rule2", rules: [], overlapped: true, prize: prize ) }
    let(:prize_condition_not_overlapped){ PrizeCondition.create(name: "Test Rule3", rules: [], prize: prize ) }

    it 'sets all conditions to not overlapped' do
      PrizeConditionRepository.set_not_overlapped([prize_condition_overlapped, prize_condition_not_overlapped])
      expect(prize_condition_overlapped.overlapped).to be_falsy
      expect(prize_condition_not_overlapped.overlapped).to be_falsy
    end
  end

  describe '.set_overlapped' do
    let(:prize){ Prize.create(name: "Test Prize", quantity: 10) }
    let(:prize_condition_overlapped){ PrizeCondition.create(name: "Test Rule2", rules: [], overlapped: true, prize: prize ) }
    let(:prize_condition_not_overlapped){ PrizeCondition.create(name: "Test Rule3", rules: [], prize: prize ) }

    it 'sets all conditions to overlapped' do
      PrizeConditionRepository.set_overlapped([prize_condition_overlapped, prize_condition_not_overlapped])
      expect(prize_condition_overlapped.overlapped).to be_truthy
      expect(prize_condition_not_overlapped.overlapped).to be_truthy
    end
  end
end