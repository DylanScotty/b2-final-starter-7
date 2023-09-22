class CreateBulkDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bulk_discounts do |t|
      t.integer :quantity
      t.float :discount
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
