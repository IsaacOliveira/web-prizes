class PrizeCondition < ApplicationRecord
  OPERATORS_LIST = [["Equal","=="],["Greater than", ">"],["Multiple of", "multiple_of?"],["Smaller than", "<"]]
  belongs_to :prize

  def self.operators_list
    OPERATORS_LIST
  end

end