class PrizeConditionRepository

  def self.with_prize_available
    PrizeCondition.joins(:prize).where("prizes.quantity > '0'")
  end

  def self.get_overlapped
    PrizeCondition.where(overlapped: true).first
  end

  def self.set_not_overlapped(conditions)
    conditions.compact.each{ | condition| condition.update_attribute(:overlapped, false) }
  end

  def self.set_overlapped(conditions)
    conditions.compact.each{ | condition| condition.update_attribute(:overlapped, true) }
  end
end