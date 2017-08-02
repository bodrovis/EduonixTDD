require "test_helper"

describe SubscriptionsController do
  it "should get new" do
    get subscriptions_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get subscriptions_create_url
    value(response).must_be :success?
  end

end
