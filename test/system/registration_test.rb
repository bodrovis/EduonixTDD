require "application_system_test_case"

class RegistrationTest < ApplicationSystemTestCase
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
    end

    assert page.has_css?('.alert.alert-success', text: 'Welcome!')
  end
end
