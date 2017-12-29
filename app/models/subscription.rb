class Subscription < ApplicationRecord
  belongs_to :prize, optional: true

  def self.subscribe!(email)
    check_subscription!(email)
    Subscription.create(last_subscription: Time.zone.now, email: email)
  end

  def self.check_subscription!(email)
    subscription = self.find_or_initialize_by(email: email)
    raise SubscriptionLimitError.new("Sorry, only one subscription per day :(") if subscription.cannot_subscribe?
  end

  def cannot_subscribe?
    !self.last_subscription.nil? and self.last_subscription.today?
  end

  def receive_prize!(prize)
    self.update_attribute(:prize, prize)
  end

end