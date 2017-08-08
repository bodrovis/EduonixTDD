class NotificationsMailer < ApplicationMailer
  before_action do
    @subscription = params[:subscription]
    @user = @subscription.user
  end

  default to: -> { @user.email }

  def notify
    mail subject: "Notification from #{@subscription.category}!"
  end
end
