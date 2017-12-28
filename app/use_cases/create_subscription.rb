class CreateSubscription

  def initialize(email:)
    @email = email
  end

  def execute
    Subscription.subscribe!(@email)
  end

end