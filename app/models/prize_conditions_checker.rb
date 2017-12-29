class PrizeConditionsChecker

  def initialize(subscription_number:)
    @subscription_number = subscription_number
    @conditions = PrizeConditionRepository.with_prize_available
  end

  def get_all_match_conditions
    matched = @conditions.select{ |condition| condition.matches_all_rules?(@subscription_number) }
    matched.unshift(get_overlapped_condition).flatten.compact
  end

  private
  def get_overlapped_condition
    PrizeConditionRepository.get_overlapped
  end

end