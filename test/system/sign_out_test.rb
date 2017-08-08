require "application_system_test_case"

class SignOutTest < ApplicationSystemTestCase
  def setup
    user = users(:user_1)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:user_id] = user.id
  end

  it 'should sign the user out' do
    visit root_url
    within '.main-menu' do
      click_link 'Logout'
    end
    assert page.has_css?('.alert.alert-success', text: 'See you later!')
    assert page.has_css?('h1', text: 'Log In')
  end
end
