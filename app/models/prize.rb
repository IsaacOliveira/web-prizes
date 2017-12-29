class Prize < ApplicationRecord

  def decrease_quantity!
    self.quantity -= 1
    self.save
  end
end