require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do

  describe "GET index" do
    context "with admin logged" do
      before { allow_any_instance_of(Admin::SessionsHelper).to receive(:logged_in?).and_return(true) }

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      let(:list_prizes){ instance_double(Admin::ListPrizes)}
      it "gets the list of prizes" do
        expect(Admin::ListPrizes).to receive(:new).and_return(list_prizes)
        expect(list_prizes).to receive(:execute)
        get :index
      end

      let(:list_prize_conditions){ instance_double(Admin::ListPrizeConditions)}
      it "gets the list of prizes" do
        expect(Admin::ListPrizeConditions).to receive(:new).and_return(list_prize_conditions)
        expect(list_prize_conditions).to receive(:execute)
        get :index
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
