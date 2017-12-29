class ProcessPrize

  def initialize(subscription:)
    @subscription = subscription
    @condition_matched_manager = ManageMatchedPrizeConditions.new(subscription_number: @subscription.id)
  end

  def execute
    prize_condition = @condition_matched_manager.first_condition
    if prize_condition.present?
      prize = prize_condition.prize
      @subscription.receive_prize!(prize)
      prize.decrease_quantity!
    end
  end
end