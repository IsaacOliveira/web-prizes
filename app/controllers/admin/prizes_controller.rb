module Admin
  class PrizesController < BaseController

    def index
      @prizes = ListPrizes.new.execute
    end

    def create
      redirect_to admin_prizes_path
    end

    def new
      @prize = Prize.new
    end

    def edit
      @prize = Prize.find(params[:id])
    end

    def update
      redirect_to admin_prizes_path
    end

    def destroy
      redirect_to admin_prizes_path
    end

  end
end