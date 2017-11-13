class HomeController < ApplicationController
  require "csv"

  def index
    @response = Example.all
  end

  def new; end

  def create
    CSV.read(params['file'].path, { :col_sep => "\t" }).each do |row|
      next if row.first.downcase == 'purchaser name'

      status = save_item(row)
    end
    redirect_to root_url
    return
  end

  private
  def save_item(row)
    item = Example.new
    item.purchaser_name = row[0]
    item.item_description = row[1]
    item.item_price = row[2]
    item.purchase_count = row[3]
    item.merchant_address = row[4]
    item.merchant_name = row[5]

    return (item.save) ? true : false
  end
end
