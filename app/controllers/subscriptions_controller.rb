class SubscriptionsController < ApplicationController
  before_action :require_authentication!

  def new
  end

  def create
    @subscription = current_user.subscriptions.build subscription_params
    if @subscription.save
      flash[:success] = "Subscribed!"
      redirect_to new_subscription_path
    else
      render :new
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:category)
  end
end
