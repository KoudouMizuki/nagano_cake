class RenamePostallCodeColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :postall_code, :postal_code
  end
end
