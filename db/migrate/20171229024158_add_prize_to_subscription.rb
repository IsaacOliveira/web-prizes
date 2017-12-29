class AddPrizeToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_reference :subscriptions, :prize
  end
end
