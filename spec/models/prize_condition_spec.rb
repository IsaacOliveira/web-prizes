require 'rails_helper'

RSpec.describe PrizeCondition, type: :model do

  let(:prize){ Prize.create(name: "Test Prize", quantity: 10) }
  describe '.operators_list' do
    it 'returns the list of operators' do
        expect(PrizeCondition.operators_list).to match_array([["Equal","=="],["Greater than", ">"],["Multiple of", "multiple_of?"],["Smaller than", "<"]])
      end
  end

  describe '#prize_name' do
    let(:prize_condition){ PrizeCondition.create(name: "Test Rule", rules: [], prize: prize ) }

      it 'returns prize name' do
        expect(prize_condition.prize_name).to be == "Test Prize"
      end
  end

  describe '#matches_all_rules?' do
    context 'given a prize condition with a greater than and a Multiple of rule' do
      let(:rule_multiple){ { "operator" => "multiple_of?", "number" => "50" }  }
      let(:rule_greater){ { "operator" => ">", "number" => "1000" }  }
      let(:prize_condition){ PrizeCondition.create(name: "Test Rule", rules: [rule_multiple, rule_greater], prize: prize ) }

      it 'returns true for argument number 1100' do
        expect(prize_condition.matches_all_rules?(1100)).to be_truthy
      end

      it 'returns false for argument number 1099' do
        expect(prize_condition.matches_all_rules?(1099)).to be_falsy
      end

      it 'returns false for argument number 900' do
        expect(prize_condition.matches_all_rules?(900)).to be_falsy
      end
    end
  end

  describe '#check_rule' do
    let(:prize_condition){ PrizeCondition.new }
    context 'given a rule Multiple of with rule number 10' do
      let(:rule_multiple){ { "operator" => "multiple_of?", "number" => "10" }  }
      it 'returns true for number 20' do
        expect(prize_condition.check_rule(20, rule_multiple)).to be_truthy
      end

      it 'returns false for number 15' do
        expect(prize_condition.check_rule(15, rule_multiple)).to be_falsy
      end
    end

    context 'given a rule Equal of with rule number 10' do
      let(:rule_equal){ { "operator" => "==", "number" => "10" }  }
      it 'returns true for number 10' do
        expect(prize_condition.check_rule(10, rule_equal)).to be_truthy
      end

      it 'returns false for number 15' do
        expect(prize_condition.check_rule(15, rule_equal)).to be_falsy
      end
    end

    context 'given a rule Greater than  with rule number 10' do
      let(:rule_greater){ { "operator" => ">", "number" => "10" }  }
      it 'returns true for number 15' do
        expect(prize_condition.check_rule(15, rule_greater)).to be_truthy
      end

      it 'returns false for number 9' do
        expect(prize_condition.check_rule(9, rule_greater)).to be_falsy
      end
    end

    context 'given a rule Smaller than with rule number 10' do
      let(:rule_smaller){ { "operator" => "<", "number" => "10" }  }
      it 'returns true for number 9' do
        expect(prize_condition.check_rule(9, rule_smaller)).to be_truthy
      end

      it 'returns false for number 15' do
        expect(prize_condition.check_rule(15, rule_smaller)).to be_falsy
      end
    end
  end
end
