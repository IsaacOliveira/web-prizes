module Admin
  class SessionsController < BaseController
    skip_before_action :load_session!

    def new
    end

    def create
      begin
        user = User.login!(username: params[:email].downcase, password: params[:password])
        log_in user
        redirect_to admin_root_path
      rescue ActiveRecord::RecordNotFound
        flash.now[:danger] = 'Invalid email/password combination'
        render action: :new
      end
    end

    def destroy
      log_out
      redirect_to root_url
    end

  end
end