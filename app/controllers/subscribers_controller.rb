class SubscribersController < ApplicationController

  def create
    @error = nil
    begin
      subscription = CreateSubscription.new(email: params[:email]).execute
      ProcessPrize.new(subscription: subscription).execute
      @prize = subscription.prize
    rescue SubscriptionLimitError => e
      @error = e
      render "error"
    end
  end

end