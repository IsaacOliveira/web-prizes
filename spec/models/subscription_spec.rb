require 'rails_helper'

RSpec.describe Subscription, type: :model do

  describe '.subscribe!' do

    let!(:subscription){ Subscription.create(email: "test@test.com", last_subscription: Date.today) }
    context 'with other subscription on the same day for the email' do
      it "raises subscription error" do
        expect{ Subscription.subscribe!("test@test.com") }.to raise_error(SubscriptionLimitError)
      end
    end

    context 'the first subscription for the email on that day' do
      it "creates the subscription error" do
        expect(Subscription.count).to be == 1
        Subscription.subscribe!("test2@test.com")
        expect(Subscription.count).to be == 2
      end
    end

  end

  describe '.check_subscription' do

    let!(:subscription){ Subscription.create(email: "test@test.com", last_subscription: Date.today) }
    context 'with other subscription on the same day for the email' do
      it "raises subscription error" do
        expect{ Subscription.check_subscription!("test@test.com") }.to raise_error(SubscriptionLimitError)
      end
    end

    context 'the first subscription for the email on that day' do
      it "not raise subscription error" do
        expect{ Subscription.check_subscription!("test2@test.com") }.to_not raise_error
      end
    end

  end

  describe '.any_subscription_today?' do

    let!(:subscription){ Subscription.create(email: "test@test.com", last_subscription: Date.today) }
    context 'with other subscription on the same day for the email' do
      it "return true" do
        expect(Subscription.any_subscription_today?("test@test.com")).to be_truthy
      end
    end

    context 'the first subscription for the email on that day' do
      it "return false" do
        expect(Subscription.any_subscription_today?("test2@test.com")).to be_falsy
      end
    end
  end

  describe '#receive_prize!' do

    let(:subscription){ Subscription.create(email: "test@test.com") }
    let(:prize) { Prize.create(name: "Test Prize", quantity: 10)}

    it 'sets the prize on the subscription' do
      subscription.receive_prize!(prize)
      expect(subscription.prize).to be == prize
    end
  end

end