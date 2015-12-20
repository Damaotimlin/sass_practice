class AddPlanToUser < ActiveRecord::Migration
  def change
    # SQL-command :which table, :what you want to added into, :data type
    add_column :users, :plan_id, :integer
  end
end