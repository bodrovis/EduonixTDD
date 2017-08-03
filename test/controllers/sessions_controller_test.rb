require "test_helper"

describe SessionsController do
  let(:user) { users(:user_1) }
  let(:my_cookies) { ActionDispatch::Request.new(Rails.application.env_config).cookie_jar }

  before(:all) { my_cookies.signed[:user_id] = nil }

  describe '#new' do
    it "should get new" do
      get new_sessions_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'should log the user in' do
      post sessions_url, params: {
          email: user.email,
          password: 'secret'
      }

      assert_redirected_to root_url
      assert_equal 'Welcome!', flash[:success]
    end
  end
end
