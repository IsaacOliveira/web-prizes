module Admin
  class PrizeConditionsController < BaseController

    before_action :find_prize_condition, only: [:edit, :update, :destroy]

    def index
      @prize_conditions = ListPrizeConditions.new.execute
    end

    def create
      @prize_condition = PrizeCondition.create(prize_condition_params)
      redirect_to admin_prize_conditions_path
    end

    def new
      @prize_condition = PrizeCondition.new
      @prizes = ListPrizes.new.execute
      @prize = Prize.new
      @operators_list = PrizeCondition.operators_list
    end

    def edit
      @prizes = ListPrizes.new.execute
      @prize = @prize_condition.prize
      @operators_list = PrizeCondition.operators_list
    end

    def update
      @prize_condition.update_attributes(prize_condition_params)
      redirect_to admin_prize_conditions_path
    end

    def destroy
      @prize_condition.destroy
      redirect_to admin_prize_conditions_path
    end

    private
    def find_prize_condition
      @prize_condition = PrizeCondition.find(params[:id])
    end

    def prize_condition_params
      params.require(:prize_condition).permit(:name, :prize_id, rules: [:operator, :number])
    end

  end
end