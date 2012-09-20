class OrdersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin, :only => [:index, :toggle_paid, :toggle_status]
	before_filter :sale_enabled

	def my
		@order = current_user.order
	end

	def show
		@order = Order.find(params[:id])
		if owner_or_admin(@order)
			render 'show'
		else
			redirect_to current_user.order
		end
	end

	def edit
		@order = Order.find(params[:id])
		unless owner_or_admin(@order)
			@order = current_user.order
		end
		if @order.open?
			render 'edit'
		else
			redirect_to @order, :flash => { :error => "Order is not open"}
		end
	end

	def update
		@order = Order.find(params[:id])

		unless owner_or_admin(@order) && @order.open?
			redirect_to current_user.order, :flash => {:error => "You can't change that order"}
		else

			if @order.update_attributes(params[:order])
				
				@order.order_items.each do |oi|
					oi.destroy if oi.quantity <= 0
				end

				redirect_to @order, :flash => { :success => "Successfully updated order"}
			else
				flash.now[:error] = "Error updating order"
				render 'edit'
			end
			
		end
	end

	# *** AJAX *** 

	def submit_order
		@order = Order.find(params[:order_id])
		
		if owner_or_admin(@order) && @order.open?
			@order.next_state
			if @order.save
				@flash = {:success => "Order submitted successfully. Please submit your payment in person to Jen Galvin on or before October 10th.\n\nMessage from Jen: Thank you for supporting me in my efforts in Making Strides Against Breast Cancer!"}
			end
		end

		@flash ||= {:error => "Order could not be submitted."}

		respond_to { |format| format.js }
	end

	# *** admin ***

	def index
		@orders = Order.all_non_empty
	end

	def toggle_paid
		@order = Order.find(params[:order_id])
		@order.paid = !@order.paid
		if @order.save
			@flash = {:success => "Order is now " + (@order.paid ? "paid" : "not paid")}
		else
			@flash = {:error => "There was an error changing the paid status"}
		end
		respond_to { |format| format.js }
	end

	def toggle_status
		@order = Order.find(params[:order_id])
		@order.next_state
		if @order.save
			@flash = {:success => @order.state}
		else
			@flash = {:error => "There was an error changing the order  status"}
		end
		respond_to { |format| format.js }
	end

	private

	def owner_or_admin(order)
		return current_user.order == order || current_user.is_admin?
	end

	def sale_enabled
    if Settings.sale_enabled == false &&
    	!current_user.is_admin? &&
	    current_user.order.state == 'open'
		      render 'store_closed'
    end
  end

end
