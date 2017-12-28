module Admin
  class PrizeConditionsController < BaseController

    def index
      @prize_conditions = ListPrizeConditions.new.execute
    end

    def create
    end

    def new
      @prize_condition = PrizeCondition.new
      @prizes = ListPrizes.new.execute
      @prize = Prize.new
    end

    def edit
      @prize_condition = PrizeCondition.new
      @prizes = ListPrizes.new.execute
      @prize = @prize_condition.prize
    end

    def update
    end

    def destroy
    end

  end
end