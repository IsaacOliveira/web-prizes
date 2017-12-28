class Admin::ListPrizes

  def execute
    Prize.all
  end

end