require 'rails_helper'

RSpec.describe User, type: :model do

  describe '.login!' do
    let!(:user){ User.create(username: "test@test.com", password: "123456") }
    context 'with a non existent username' do

      it "raises record not found error" do
        expect{ User.login!(username: "test2@test.com", password: "123456") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    context 'with a existent username and wrong password' do
      it "raises record not found error" do
        expect{ User.login!(username: "test@test.com", password: "12345") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with a existent username and right password' do
      it "updates the session token" do
        previous_session_token = user.session_token
        new_session_token = User.login!(username: "test@test.com", password: "123456").session_token
        expect(previous_session_token).not_to eq new_session_token
      end

      it "returns the user" do
        expect(User.login!(username: "test@test.com", password: "123456")).to be == user
      end
    end
  end
end
