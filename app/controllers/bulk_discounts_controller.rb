class BulkDiscountsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @discounts = @merchant.bulk_discounts
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @discount = BulkDiscount.find(params[:id])
    end

    def new
        @merchant = Merchant.find(params[:id])
    end
end