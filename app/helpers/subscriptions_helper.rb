module SubscriptionsHelper
  def options_for_category_select
    options_for_select Subscription::CATEGORIES - current_user.subscriptions.pluck(:category)
  end
end
