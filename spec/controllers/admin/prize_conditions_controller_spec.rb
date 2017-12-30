require 'rails_helper'

RSpec.describe Admin::PrizeConditionsController, type: :controller do

  context "with admin logged" do
    before(:each) do
      allow_any_instance_of(Admin::SessionsHelper).to receive(:logged_in?).and_return(true)
    end

    describe "GET #index" do
      it "render index template" do
        get :index
        expect(response).to render_template("index")
      end

      let(:list_prize_conditions){ instance_double(Admin::ListPrizeConditions)}
      it "gets the list of prizes" do
        expect(Admin::ListPrizeConditions).to receive(:new).and_return(list_prize_conditions)
        expect(list_prize_conditions).to receive(:execute)
        get :index
      end
    end

    describe "POST #create" do
      let(:prize_condition_params){ { name: "test", prize_id: 1, rules: [] } }

      it 'creates a prize condition' do
        expect(PrizeCondition).to receive(:create)
        post :create, params: {  prize_condition: prize_condition_params }
      end

      it "redirect to admin prizes page" do
        allow(PrizeCondition).to receive(:create)
        post :create, params: {  prize_condition: prize_condition_params }
        expect(response).to redirect_to(admin_root_path)
      end

    end

    describe "PUT #update" do
      let(:prize_condition){ instance_double(PrizeCondition)}
      let(:prize_condition_params){ { name: "test", prize_id: 1, rules: [] } }

      it 'instantiate a prize_condition' do
        expect(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:update_attributes)
        put :update, params: { id: "1", prize_condition: prize_condition_params }
      end

      it 'update the prize_conditions attributes' do
        allow(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        expect(prize_condition).to receive(:update_attributes)
        put :update, params: { id: "1", prize_condition: prize_condition_params }
      end

      it "redirect to admin prize_conditions page" do
        allow(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:update_attributes)
        put :update, params: { id: "1", prize_condition: prize_condition_params }
        expect(response).to redirect_to(admin_root_path)
      end
    end

    describe "GET #new" do
      it "render new template" do
        get :new
        expect(response).to render_template("new")
      end

      it 'instantiate a prize condition' do
        expect(PrizeCondition).to receive(:new)
        get :new
      end

      it 'instantiate a prize' do
        expect(Prize).to receive(:new)
        get :new
      end

      let(:list_prizes){ instance_double(Admin::ListPrizes)}
      it "gets the list of prizes" do
        expect(Admin::ListPrizes).to receive(:new).and_return(list_prizes)
        expect(list_prizes).to receive(:execute)
        get :new
      end

      it "gets the list of operators" do
        expect(PrizeCondition).to receive(:operators_list)
        get :new
      end
    end

    describe "GET #edit" do
      let(:prize_condition){ instance_double(PrizeCondition)}
      it "render edit template" do
        allow(PrizeCondition).to receive(:find).and_return(prize_condition)
        allow(prize_condition).to receive(:prize)

        get :edit, params: { id: "1"}
        expect(response).to render_template("edit")
      end

      it 'gets the prize condition' do
        expect(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:prize)
        get :edit, params: { id: "1"}
      end

      it 'gets the prize of condition' do
        allow(PrizeCondition).to receive(:find).and_return(prize_condition)
        expect(prize_condition).to receive(:prize)
        get :edit, params: { id: "1"}
      end

      it "gets the list of operators" do
        allow(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:prize)
        expect(PrizeCondition).to receive(:operators_list)
        get :edit, params: { id: "1"}
      end
    end

    describe "DELETE #destroy" do
      let(:prize_condition){ instance_double(PrizeCondition)}

      it 'finds the prize condition' do
        expect(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:destroy)
        delete :destroy, params: { id: "1" }
      end

      it 'destroy the prize_condition' do
        allow(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        expect(prize_condition).to receive(:destroy)
        delete :destroy, params: { id: "1" }
      end

      it "redirect to admin prize conditions page" do
        allow(PrizeCondition).to receive(:find).with("1").and_return(prize_condition)
        allow(prize_condition).to receive(:destroy)
        delete :destroy, params: { id: "1"}
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end

end
