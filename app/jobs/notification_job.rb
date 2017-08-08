class NotificationJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    NotificationsMailer.with(subscription: subscription).notify.deliver_now
    NotificationJob.set(wait_until: Time.now.tomorrow.change(hour: 9)).perform_later(self)
  end
end
