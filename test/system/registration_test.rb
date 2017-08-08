require "application_system_test_case"

class RegistrationTest < ApplicationSystemTestCase
  def setup
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:user_id] = nil
  end
  test "registration should succeed with proper user data" do
    visit new_user_url

    #assert_selector "h1", text: "Registration"
    assert page.has_css?('h1', text: 'Registration')

    assert_difference 'User.count', +1 do
      within '#new_user' do
        fill_in 'Name', with: 'Demo Name'
        fill_in 'user[email]', with: 'demo@example.com'
        fill_in 'user[password]', with: 'secret'
        fill_in 'user[password_confirmation]', with: 'secret'
        click_button 'Register!'
      end
      assert page.has_css?('.alert.alert-success', text: 'Welcome!')
    end
  end
end
