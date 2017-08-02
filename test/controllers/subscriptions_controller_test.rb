require "test_helper"

describe SubscriptionsController do
  let(:my_cookies) { ActionDispatch::Request.new(Rails.application.env_config).cookie_jar }
  let(:user) { users(:user_1) }

  describe '#create' do
    it 'should create a new subscription' do
      my_cookies.signed[:user_id] = user.id
      assert_difference 'user.subscriptions.count', +1 do
        post subscriptions_url, params: {
            subscription: {
                category: 'test'
            }
        }
      end

      assert_redirected_to new_subscription_path
      assert_equal 'Subscribed!', flash[:success]
    end
  end

  describe '#new' do
    it 'should not allow unauthenticated user to access the page' do
      my_cookies.signed[:user_id] = nil
      get new_subscription_path
      assert_redirected_to new_session_path
      assert_equal 'Please log in!', flash[:danger]
    end

    it 'should allow authenticated user to access the page' do
      my_cookies.signed[:user_id] = user.id
      get new_subscription_path
      assert_response :success
    end
  end
end
