require 'rails_helper'

RSpec.describe Admin::PrizesController, type: :controller do

  context "with admin logged" do
    before(:each) do
      allow_any_instance_of(Admin::SessionsHelper).to receive(:logged_in?).and_return(true)
    end

    describe "GET #index" do
      it "render index template" do
        get :index
        expect(response).to render_template("index")
      end

      let(:list_prizes){ instance_double(Admin::ListPrizes)}
      it "gets the list of prizes" do
        expect(Admin::ListPrizes).to receive(:new).and_return(list_prizes)
        expect(list_prizes).to receive(:execute)
        get :index
      end
    end

    describe "POST #create" do
      let(:prize_params){ { name: "test", quantity: "10"} }

      it 'creates a prize' do
        expect(Prize).to receive(:create)
        post :create, params: {  prize: prize_params }
      end

      it "redirect to admin prizes page" do
        allow(Prize).to receive(:create)
        post :create, params: {  prize: prize_params }
        expect(response).to redirect_to(admin_prizes_path)
      end

    end

    describe "PUT #update" do
      let(:prize){ instance_double(Prize)}
      let(:prize_params){ { name: "test", quantity: "10"} }

      it 'instantiate a prize' do
        expect(Prize).to receive(:find).with("1").and_return(prize)
        allow(prize).to receive(:update_attributes)
        put :update, params: { id: "1", prize: prize_params }
      end

      it 'update the prizes attributes' do
        allow(Prize).to receive(:find).with("1").and_return(prize)
        expect(prize).to receive(:update_attributes)
        put :update, params: { id: "1", prize: prize_params }
      end

      it "redirect to admin prizes page" do
        allow(Prize).to receive(:find).with("1").and_return(prize)
        allow(prize).to receive(:update_attributes)
        put :update, params: { id: "1", prize: prize_params }
        expect(response).to redirect_to(admin_prizes_path)
      end
    end

    describe "GET #new" do
      it "render new template" do
        get :new
        expect(response).to render_template("new")
      end

      it 'instantiate a prize' do
        expect(Prize).to receive(:new)
        get :new
      end
    end

    describe "GET #edit" do
      it "render edit template" do
        allow(Prize).to receive(:find)
        get :edit, params: { id: "1"}
        expect(response).to render_template("edit")
      end

      it 'instantiate a prize' do
        expect(Prize).to receive(:find).with("1")
        get :edit, params: { id: "1"}
      end
    end

    describe "DELETE #destroy" do
      let(:prize){ instance_double(Prize)}

      it 'finds the prize' do
        expect(Prize).to receive(:find).with("1").and_return(prize)
        allow(prize).to receive(:destroy)
        delete :destroy, params: { id: "1" }
      end

      it 'destroy the prize' do
        allow(Prize).to receive(:find).with("1").and_return(prize)
        expect(prize).to receive(:destroy)
        delete :destroy, params: { id: "1" }
      end

      it "redirect to admin prizes page" do
        allow(Prize).to receive(:find).with("1").and_return(prize)
        allow(prize).to receive(:destroy)
        delete :destroy, params: { id: "1"}
        expect(response).to redirect_to(admin_prizes_path)
      end
    end
  end

end
