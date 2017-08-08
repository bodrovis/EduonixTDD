require "application_system_test_case"

class SubscriptionsTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_1)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:user_id] = @user.id
  end
  test "user should be able to subscribe to categories" do
    visit root_url
    assert page.has_css?('h1', text: 'Subscriptions')
    within '#subscriptions' do
      assert page.has_content?('ruby')
    end

    within '#new-subscription' do
      select('java', from: 'subscription[category]')
      click_button 'Subscribe!'
    end

    within '#subscriptions' do
      assert page.has_content?('java')
    end
    within '#new-subscription' do
      assert page.has_select?('subscription[category]', options: %w(php python))
      assert_selector '[name="subscription[category]"] option', count: 2
    end
    take_screenshot
  end
end
