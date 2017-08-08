class Subscription < ApplicationRecord
  CATEGORIES = %w(ruby php java python)

  belongs_to :user

  validates :category, uniqueness: {scope: :user}, inclusion: {in: CATEGORIES}

  after_create :queue_notification

  private

  def queue_notification
    NotificationJob.set(wait_until: Time.now.tomorrow.change(hour: 9)).perform_later(self)
  end
end
