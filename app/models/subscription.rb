class Subscription < ApplicationRecord

  def self.subscribe!(email)
    subscription = self.find_or_create_by(email: email)
    raise SubscriptionLimitError.new("Sorry, only one subscription per day :(") if subscription.cannot_subscribe?
    subscription.update_attribute(:last_subscription, Time.zone.now)
  end

  def cannot_subscribe?
    !self.last_subscription.nil? and self.last_subscription.today?
  end

end