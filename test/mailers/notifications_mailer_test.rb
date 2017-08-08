require "test_helper"

describe NotificationsMailer do
  def setup
    @subscription = subscriptions(:one)
  end

  it "notify" do
    mail = NotificationsMailer.with(subscription: @subscription).notify
    assert_equal "Notification from #{@subscription.category}!", mail.subject
    assert_equal [@subscription.user.email], mail.to
    assert_equal ["admin@example.com"], mail.from
    assert_includes mail.body.encoded, "A new notification from #{@subscription.category}"
  end
end
