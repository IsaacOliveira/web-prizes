class Prize < ApplicationRecord

  def decrease_quantity!
    self.quantity -= 1
    self.save
  end

  def has_conditions?
    PrizeCondition.where(prize_id: self.id).any?
  end
end