class PrizeCondition < ApplicationRecord
  OPERATORS_LIST = [["Equal","=="],["Greater than", ">"],["Multiple of", "multiple_of?"],["Smaller than", "<"]]
  belongs_to :prize

  def self.operators_list
    OPERATORS_LIST
  end

  def prize_name
    self.prize.name
  end

  def matches_all_rules?(number)
    self.rules.all?{ | rule| check_rule(number, rule) }
  end

  def check_rule(number, rule)
    number.send(rule["operator"], rule["number"].to_i)
  end

end