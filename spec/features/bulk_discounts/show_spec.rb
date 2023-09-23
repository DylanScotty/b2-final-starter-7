require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Show' do
  before :each do
    @merchant = Merchant.create!(name: 'Computer Parts')

    @bulk_discount = BulkDiscount.create!(quantity: 10, discount: 20, merchant_id: @merchant.id)

    visit merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

   describe 'Show page' do
     it "shows the discount's quantity and percentage" do 
        save_and_open_page
      expect(page).to have_content("Discount ##{@bulk_discount.id}")
      expect(page).to have_content("Quantity threshold: #{@bulk_discount.quantity} items")
      expect(page).to have_content("Discount percentage: #{@bulk_discount.discount}%")
     end

     it "has a link to edit the discount" do
        expect(page).to have_link("Edit Bulk Discount", href: edit_merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))

        click_link "Edit Bulk Discount"

        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant.id, @bulk_discount.id))
     end
   end
end