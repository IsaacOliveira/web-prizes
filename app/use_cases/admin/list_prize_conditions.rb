class Admin::ListPrizeConditions

  def execute
    PrizeCondition.all
  end

end