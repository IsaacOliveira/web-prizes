require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do

  describe "GET index" do
    context "with admin logged" do
      it "renders the index template" do
        allow_any_instance_of(Admin::SessionsHelper).to receive(:logged_in?).and_return(true)
        get :index
        expect(response).to render_template("index")
      end
    end

    context "without admin logged" do
      it "redirect to login page" do
        get :index
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

end
