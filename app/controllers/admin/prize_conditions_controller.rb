module Admin
  class PrizeConditionsController < BaseController
    OPERATORS_LIST = [["Equal","=="],["Greater than", ">"],["Multiple of", "multiple_of?"],["Smaller than", "<"]]

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
      @operators_list = OPERATORS_LIST
    end

    def edit
      @prize_condition = PrizeCondition.find(params[:id])
      @prizes = ListPrizes.new.execute
      @prize = @prize_condition.prize
      @operators_list = OPERATORS_LIST
    end

    def update
      @prize_condition = PrizeCondition.find(params[:id])
      @prize_condition.update_attributes(prize_condition_params)
      redirect_to admin_prize_conditions_path
    end

    def destroy
      redirect_to admin_prize_conditions_path
    end

    private
    def prize_condition_params
      params.require(:prize_condition).permit(:name, :prize_id, rules: [:operator, :number])
    end

  end
end