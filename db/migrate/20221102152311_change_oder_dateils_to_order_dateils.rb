class ChangeOderDateilsToOrderDateils < ActiveRecord::Migration[6.1]
  def change
    rename_table :oder_dateils, :order_dateils
  end
end
