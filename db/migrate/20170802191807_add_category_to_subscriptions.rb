class AddCategoryToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :category, :string
  end
end
