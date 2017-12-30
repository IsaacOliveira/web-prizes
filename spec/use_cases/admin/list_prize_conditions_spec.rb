RSpec.describe Admin::ListPrizeConditions, type: :model do

  describe '#execute' do
    it 'calls PrizeCondition.all' do
      expect(PrizeCondition).to receive(:all)
      Admin::ListPrizeConditions.new.execute
    end
  end
end