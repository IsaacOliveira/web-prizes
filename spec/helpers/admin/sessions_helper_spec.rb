require 'rails_helper'

RSpec.describe Admin::SessionsHelper, type: :helper do

  describe '#log_in' do
    let(:user){ instance_double("User", :session_token => "1111")}
    it 'sets session token form user' do
      helper.log_in(user)
      expect(session[:session_token]).to be == user.session_token
    end
  end

  describe '#current_user' do
    it 'gets user by session token' do
      session[:session_token] = "1234"
      expect(User).to receive(:find_by).with(session_token: "1234")
      helper.current_user
    end
  end

  describe 'logged_in?' do
    context 'has current_user'
    let(:user){ instance_double("User")}

    it 'returns true' do
      allow(User).to receive(:find_by).and_return(user)
      expect(helper.logged_in?).to be_truthy
    end

    context 'has not current_user' do
      it 'returns false' do
        allow(User).to receive(:find_by).and_return(nil)
        expect(helper.logged_in?).to be_falsy
      end
    end
  end

  describe 'log_out' do
    it 'deletes the session' do
      expect(session).to receive(:delete).with(:session_token)
      helper.log_out
    end

    let(:user){ instance_double("User", :session_token => "1111")}
    it 'sets current user to nil' do
      helper.log_in(user)
      helper.log_out
      expect(helper.instance_variable_get(:@current_user)).to be == nil
    end
  end

end
