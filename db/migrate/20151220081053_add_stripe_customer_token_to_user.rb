class AddStripeCustomerTokenToUser < ActiveRecord::Migration
  def change
    # SQL-command :which table, :what you want to added into, :data type
    add_column :users, :stripe_customer_token, :string
  end
end