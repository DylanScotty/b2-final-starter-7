require 'rails_helper'

RSpec.describe 'Merchant Discounts New Page' do
  before :each do
    @merchant = Merchant.create!(name: 'Computer Parts')

    @customer_1 = Customer.create!(first_name: 'Ian', last_name: 'Ross')
    @customer_2 = Customer.create!(first_name: 'Martin', last_name: 'Timmy')
    @customer_3 = Customer.create!(first_name: 'Elon', last_name: 'Musk')
    @customer_4 = Customer.create!(first_name: 'Jimmy', last_name: 'Andrews')
    @customer_5 = Customer.create!(first_name: 'Tina', last_name: 'Turner')
    @customer_6 = Customer.create!(first_name: 'Kim', last_name: 'Jester')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Mouse", description: "It lights up", unit_price: 10, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: "Keyboard", description: "Mechanical is best", unit_price: 8, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: "Switches", description: "Best on the market", unit_price: 5, merchant_id: @merchant.id)
    @item_4 = Item.create!(name: "Webcam", description: "40000K HD", unit_price: 1, merchant_id: @merchant.id)

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    # @bulk_discount_1 = BulkDiscount.create!(quantity: 10, discount: 20, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(quantity: 15, discount: 30, merchant_id: @merchant.id)
    @bulk_discount_3 = BulkDiscount.create!(quantity: 2, discount: 5, merchant_id: @merchant.id)
  end

  it 'shows the user a form to add a new bulk discount' do
    visit new_merchant_bulk_discount_path(@merchant.id)
    
    expect(page).to have_field("Quantity threshold:")
    expect(page).to have_field("Discount percentage:")
  end

  it 'redirects to the bulk discount page when the form is filled out with data' do
    visit new_merchant_bulk_discount_path(@merchant.id)
  
    fill_in "Quantity threshold:", with: 10
    fill_in "Discount percentage:", with: 20
  
    click_button "Create Bulk discount"
  
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant.id))
    save_and_open_page
  
    expect(page).to have_content("Discount amount: 20.0%")
    expect(page).to have_content("Discount quantity threshold: 10 items")
  end
end