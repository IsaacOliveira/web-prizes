class RulesChecker

  def initialize(subscriber_number:, rules:)
    @subscriber_number = subscriber_number
    @rules = rules
  end

  def matches_all_rules?
    @rules.all?{ | rule| check_rule(@subscriber_number, rule) }
  end

  def check_rule(subscriber_number, rule)
    subscriber_number.send(rule["operator"], rule["number"].to_i)
  end
end