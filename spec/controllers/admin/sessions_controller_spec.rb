require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  let(:user){ instance_double(User)}
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'calls user login with credentials' do
       expect(User).to receive(:login!).with(username: "test@test.com", password: "123456").and_return(user)
       expect_any_instance_of(Admin::SessionsHelper).to receive(:log_in).with(user)
       post :create, params: { email: "test@test.com", password: "123456"}
    end

    context 'with correct login' do
      it "redirect to  admin root path" do
        allow(User).to receive(:login!)
        allow_any_instance_of(Admin::SessionsHelper).to receive(:log_in)
        post :create, params: { email: "test@test.com", password: "123456"}
        expect(response).to redirect_to(admin_root_url)
      end
    end

    context 'with wrong login' do
      it "redirect to sessions new path" do
        post :create, params: { email: "test@test.com", password: "123456"}
        expect(response).to render_template("new")
      end
    end
  end

    describe "DELETE #destroy" do
      it 'calls logout' do
        expect_any_instance_of(Admin::SessionsHelper).to receive(:log_out)
        delete :destroy, params: {id: 1}
      end

      it "redirect_to home" do
        delete :destroy, params: {id: 1}
        expect(response).to redirect_to(root_url)
      end
    end

end
