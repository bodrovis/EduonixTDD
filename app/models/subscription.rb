class Subscription < ApplicationRecord
  belongs_to :user

  validates :category, uniqueness: {scope: :user}
end
