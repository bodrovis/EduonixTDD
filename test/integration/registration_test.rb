require "test_helper"

# To be handled correctly this spec must end with "Integration Test"
describe "Registration Integration Test" do
  let(:my_cookies) { ActionDispatch::Request.new(Rails.application.env_config).cookie_jar }
  before(:all) { my_cookies.signed[:user_id] = nil }

  it 'should allow user to register with proper credentials' do
    VCR.use_cassette("currency_rates") do
      get new_user_path
      assert_response :success
      assert_select 'h1', 'Registration'
      assert_difference 'User.count', +1 do
        post users_url, params: {
            user: {
                email: 'john@example.com',
                name: 'John Doe',
                password: 'supersecret',
                password_confirmation: 'supersecret'
            }
        }
      end

      assert_redirected_to root_url
      follow_redirect!
      assert_select '.alert.alert-success', 'Welcome!'
      assert_select '.main-menu' do
        assert_select '.user-email', 'john@example.com'
        assert_select 'a.logout', 'Logout'
      end
    end
  end
end
