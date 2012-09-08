class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def add_to_order
    @item = Item.find(params[:item_id])
    @order = current_user.order
    @order_item = @order.order_items.where("item_id = ?", @item.id).first
    if @order_item.nil?
      @order_item = @order.order_items.create
      @order_item.item = @item
      @order_item.quantity = 1
    else
      logger.debug @order_item.inspect
      @order_item.quantity = @order_item.quantity + 1
    end

    if @order_item.save!
      @flash_key = 'success'
      @flash_value = "You now have #{@order_item.quantity} of the #{@item.name} in your cart"
    else
      @flash_key = 'error'
      @flash_value = "There was an error and the apple could not be added to your cart"
    end

    respond_to do |format|
      format.js
    end
  end
end
