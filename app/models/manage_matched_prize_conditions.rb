class ManageMatchedPrizeConditions

  def initialize(subscription_number:)
    @prize_condition_checker = PrizeConditionsChecker.new(subscription_number: subscription_number)
  end

  def first_condition
    all_conditions = @prize_condition_checker.get_all_match_conditions
    gets_first_condition_overlaps_others(all_conditions)
  end

  private
  def gets_first_condition_overlaps_others(all_conditions)
    prize_condition = all_conditions.shift
    PrizeConditionRepository.set_overlapped(all_conditions)
    PrizeConditionRepository.set_not_overlapped([prize_condition])
    prize_condition
  end

end