require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do

  describe "POST #create" do
    let(:subscription){ instance_double("Subscription" ,:prize => double)}
    let(:subscription_use_case){ instance_double(CreateSubscription)}
    let(:process_prize_use_case){ instance_double(ProcessPrize)}

    context 'with valid subscription' do
      it "calls create subscription use case" do
        expect(CreateSubscription).to receive(:new).with(email: "teste@email.com").and_return(subscription_use_case)
        expect(subscription_use_case).to receive(:execute).and_return(subscription)
        allow(ProcessPrize).to receive(:new).and_return(process_prize_use_case)
        allow(process_prize_use_case).to receive(:execute)
        post :create, params: { email: "teste@email.com" }, xhr: true
      end

      it "calls create process prize use case" do
        allow(CreateSubscription).to receive(:new).with(email: "teste@email.com").and_return(subscription_use_case)
        allow(subscription_use_case).to receive(:execute).and_return(subscription)
        expect(ProcessPrize).to receive(:new).with(subscription: subscription).and_return(process_prize_use_case)
        expect(process_prize_use_case).to receive(:execute)
        post :create, params: { email: "teste@email.com" }, xhr: true
      end

      subject { post :create, params: { email: "teste@email.com" }, xhr: true }
      it "renders create template" do
        expect(subject).to render_template(:create)
      end
    end

    context "with a invalid subscription" do
      subject { post :create, params: { email: "teste@email.com" }, xhr: true }

      it "renders error template" do
        allow(CreateSubscription).to receive(:new).with(email: "teste@email.com").and_return(subscription_use_case)
        allow(subscription_use_case).to receive(:execute).and_raise(SubscriptionLimitError)
        expect(subject).to render_template(:error)
      end
    end
  end

end
