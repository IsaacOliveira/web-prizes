module Admin
  class BaseController < ApplicationController
    include SessionsHelper

    before_action :load_session!

    def index
      @prize_conditions = ListPrizeConditions.new.execute
      @prizes = ListPrizes.new.execute
    end

  end
end