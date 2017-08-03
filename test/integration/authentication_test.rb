require "test_helper"

# To be handled correctly this spec must end with "Integration Test"
describe "Authentication Integration Test" do
  subject { users(:user_1) }
  let(:my_cookies) { ActionDispatch::Request.new(Rails.application.env_config).cookie_jar }

  describe 'Authenticated user' do
    before(:all) { my_cookies.signed[:user_id] = subject.id }

    it 'should be able to log out' do
      delete sessions_url
      assert_response :redirect
      follow_redirect!
      assert_select '.alert.alert-success', 'See you later!'
    end
  end


  describe 'Unauthenticated user' do
    before(:all) { my_cookies.signed[:user_id] = nil }
    it "should be able to log in with valid credentials" do
      get root_url
      assert_response :redirect
      #assert_redirected_to ...
      follow_redirect!
      assert_select 'h1', 'Log In'
      post sessions_url, params: {
          email: subject.email,
          password: 'secret'
      }
      assert_response :redirect
      follow_redirect!
      assert_select 'h1', 'Subscriptions'
    end

    it "should not be able to log in with invalid credentials" do
      post sessions_url, params: {
          email: subject.email,
          password: 'invalid'
      }
      assert_response :success
      assert_select '.alert.alert-danger', 'Incorrect email and/or password!'
    end
  end
end