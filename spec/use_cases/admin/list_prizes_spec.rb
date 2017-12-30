RSpec.describe Admin::ListPrizes, type: :model do

  describe '#execute' do
    it 'calls Prize.all' do
      expect(Prize).to receive(:all)
      Admin::ListPrizes.new.execute
    end
  end
end