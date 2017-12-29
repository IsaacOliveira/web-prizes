module Admin
  class PrizesController < BaseController

    def index
      @prizes = ListPrizes.new.execute
    end

    def create
      Prize.create(prize_params)
      redirect_to admin_prizes_path
    end

    def new
      @prize = Prize.new
    end

    def edit
      @prize = Prize.find(params[:id])
    end

    def update
      @prize = Prize.find(params[:id])
      @prize.update_attributes(prize_params)
      redirect_to admin_prizes_path
    end

    def destroy
      Prize.find(params[:id]).destroy
      redirect_to admin_prizes_path
    end

    private
    def prize_params
      params.require(:prize).permit(:name, :quantity)
    end

  end
end