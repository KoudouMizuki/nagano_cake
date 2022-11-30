class ChangeOdersToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_table :oders, :orders
  end
end
