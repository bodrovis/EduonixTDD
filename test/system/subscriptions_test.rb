require "application_system_test_case"

class SubscriptionsTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_1)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:user_id] = @user.id
  end
  test "visiting the index" do
    visit root_url
    assert page.has_css?('h1', text: 'Subscriptions')
    within '#subscriptions' do
      assert page.has_content?('ruby')
    end

    within '#new-subscription' do
      
    end
  end
end
