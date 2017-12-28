class SubscribersController < ApplicationController

  def create
    @error = nil
    begin
      CreateSubscription.new(email: params[:email]).execute
    rescue SubscriptionLimitError => e
      @error = e
    end
  end

end