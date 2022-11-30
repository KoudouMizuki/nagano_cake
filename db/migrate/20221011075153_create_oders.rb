class CreateOders < ActiveRecord::Migration[6.1]
  def change
    create_table :oders do |t|
      t.integer :customer_id, null: false
      t.integer :peyment_amount, null: false
      t.integer :peyment_type, null: false
      t.integer :postage, null: false
      t.string :address, null: false
      t.string :postal_code, null: false
      t.string :name, null: false
      t.integer :order_status, null: false

      t.timestamps
    end
  end
end
