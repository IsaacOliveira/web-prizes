class Admin::BaseController < ApplicationController
  include Admin::SessionsHelper

  before_action :load_session!

  def index
  end

end