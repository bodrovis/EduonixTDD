require "test_helper"

describe SessionsController do
  let(:user) { users(:user_1) }
  describe '#new' do
    it "should get new" do
      get new_session_url
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
