class ProcessPrize

  def initialize(subscription:)
    @subscription = subscription
    @matched_condition = MatchedPrizeConditions.new(subscription_number: @subscription.id)
  end

  def execute
    prize_condition = @matched_condition.first_condition
    if prize_condition.present?
      prize = prize_condition.prize
      @subscription.receive_prize!(prize)
      prize.decrease_quantity!
    end
  end
end