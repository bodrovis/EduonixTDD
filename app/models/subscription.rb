class Subscription < ApplicationRecord
  CATEGORIES = %w(ruby php java python)

  belongs_to :user

  validates :category, uniqueness: {scope: :user}, inclusion: {in: CATEGORIES}
end
