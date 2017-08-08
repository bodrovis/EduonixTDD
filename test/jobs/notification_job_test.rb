require "test_helper"

describe NotificationJob do
  it 'creation of a subscription should schedule a job' do
    assert_no_enqueued_jobs
    
    assert_enqueued_with(
        job: NotificationJob,
        at: Time.now.tomorrow.change(hour: 9),
        queue: 'default'
    ) do
      users(:user_8).subscriptions.create category: 'ruby'
    end
    assert_enqueued_jobs 1
  end
end
