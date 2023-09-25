require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Edit' do
  before :each do
    @merchant = Merchant.create!(name: 'Computer City')

    @bulk_discount = BulkDiscount.create!(quantity: 10, discount: 20, merchant_id: @merchant.id)

   visit merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  describe 'User Story 5' do
    it "displays a link to edit the bulk discount" do

      expect(page).to have_link "Edit Bulk Discount"
    end

    it "alows the visitor to make changes to the discount" do

      click_link "Edit Bulk Discount"
      
      fill_in "Quantity threshold:", with: 15
      fill_in "Discount percentage:", with: 25

      click_button "Update"
      
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount))

      expect(page).to have_content("Discount percentage: 25.0%")
      expect(page).to have_content("Quantity threshold: 15 items")
      end
  end
end