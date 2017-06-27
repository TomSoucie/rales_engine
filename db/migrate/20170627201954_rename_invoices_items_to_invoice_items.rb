class RenameInvoicesItemsToInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    rename_table :invoices_items, :invoice_items 
  end
end
