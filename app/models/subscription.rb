class Subscription < ApplicationRecord
  belongs_to :prize, optional: true

  def self.subscribe!(email)
    check_subscription!(email)
    Subscription.create(last_subscription: DateTime.now, email: email)
  end

  def self.check_subscription!(email)
    raise SubscriptionLimitError.new("Sorry, only one subscription per day :(") if self.any_subscription_today?(email)
  end

  def self.any_subscription_today?(email)
    self.where(email: email, last_subscription: Date.today.beginning_of_day..Date.today.end_of_day).any?
  end

  def receive_prize!(prize)
    self.update_attribute(:prize, prize)
  end

end