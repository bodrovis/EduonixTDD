require "test_helper"

# To be handled correctly this spec must end with "Integration Test"
describe "Subscriptions Creation Integration Test" do
  let(:user) { users(:user_5) }
  let(:my_cookies) { ActionDispatch::Request.new(Rails.application.env_config).cookie_jar }
  before(:all) { my_cookies.signed[:user_id] = user.id }

  it 'should allow to create a subscription' do
    get new_subscription_url
    assert_response :success

    assert_difference 'user.subscriptions.count', +1 do
      post subscriptions_url, params: {
          subscription: {
              category: 'ruby'
          }
      }
    end

    follow_redirect!
    assert_select '.alert.alert-success', 'Subscribed!'
    assert_select '#subscriptions' do
      assert_select 'li', 'ruby'
    end

    assert_select '#new-subscription select[name="subscription[category]"]' do |element|
      assert_equal element.children.search('option').count, 2
      assert_select 'option', 'php'
      assert_select 'option', 'java'
    end
  end
end
