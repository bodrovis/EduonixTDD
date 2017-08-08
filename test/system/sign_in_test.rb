require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_1)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:user_id] = nil
  end
  test "sign in should succeed with proper credentials" do
    VCR.use_cassette("currency_rates") do
      visit root_url

      assert page.has_css?('h1', text: 'Log In')

      within '#new_session' do
        fill_in 'email', with: @user.email
        fill_in 'password', with: 'secret'
        click_button 'Log In'
      end

      assert page.has_css?('h1', text: 'Subscriptions')
      assert page.has_css?('.alert.alert-success',text:  'Welcome!')
    end
  end
end
