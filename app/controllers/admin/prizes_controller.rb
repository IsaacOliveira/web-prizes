module Admin
  class PrizesController < BaseController

    before_action :find_prize, only: [:edit, :update, :destroy]

    def index
      @prizes = ListPrizes.new.execute
    end

    def create
      Prize.create(prize_params)
      flash[:success] = 'Prize created'
      redirect_to admin_prizes_path
    end

    def new
      @prize = Prize.new
    end

    def edit
    end

    def update
      @prize.update_attributes(prize_params)
      flash[:success] = 'Prize updated'
      redirect_to admin_prizes_path
    end

    def destroy
      @prize.destroy
      flash[:success] = 'Prize deleted'
      redirect_to admin_prizes_path
    end

    private
    def find_prize
      @prize = Prize.find(params[:id])
    end

    def prize_params
      params.require(:prize).permit(:name, :quantity)
    end

  end
end