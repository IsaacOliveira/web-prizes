require 'rails_helper'

RSpec.describe Prize, type: :model do

  let(:prize) { Prize.create(name: "Test Prize", quantity: 10)}

  describe '#decrease_quantity!' do

    it 'decrease the prize quantity by one' do
      prize.decrease_quantity!
      expect(prize.quantity).to be == 9
    end
  end

  describe '#has_conditions?' do

    context 'given a prize with a associated condition' do
      let!(:prize_condition){ PrizeCondition.create(prize: prize, name: "Condition Test") }
      it "returns true" do
        expect(prize.has_conditions?).to be_truthy
      end
    end

    context 'given the prize without associated conditions' do
      it "returns false" do
        expect(prize.has_conditions?).to be_falsy
      end
    end
  end

end