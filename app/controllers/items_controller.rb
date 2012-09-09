class ItemsController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    if user_signed_in?
      @items = Item.all
      render 'index'
    else
      redirect_to page_path('home')
    end
  end

  def add_to_order
    @item = Item.find(params[:item_id])
    @order = current_user.order
    if @order.open?
      @order_item = @order.order_items.where("item_id = ?", @item.id).first
      if @order_item.nil?
        @order_item = @order.order_items.create
        @order_item.item = @item
        @order_item.quantity = 1
      else
        logger.debug @order_item.inspect
        @order_item.quantity = @order_item.quantity + 1
      end

      if @order_item.save
        @flash = { :success => "You now have #{@order_item.quantity} of the #{@item.name} in your cart" }
      else
        @flash = { :error => "There was an error and the apple could not be added to your cart" }
      end
    else
      @flash = { :error => "Your order is already being processed"}
    end

    respond_to do |format|
      format.js
    end
  end
end
