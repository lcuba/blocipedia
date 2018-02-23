class AddUpgradedAndStripeIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :upgraded, :boolean
    add_column :users, :stripeid, :string
  end
end
