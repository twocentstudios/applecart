class OrdersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin, :only => :index

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
					oi.destroy if oi.quantity == 0
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
		
		unless owner_or_admin(@order)
			@flash_key = 'error'
			@flash_value = "Order could not be submitted."
		end

		if @order.open?
			@order.next_state!
			@flash_key = 'success'
			@flash_value = "Order submitted successfully. Please submit your payment in person as soon as possible."
		else
			@flash_key = 'error'
			@flash_value = "Order could not be submitted."
		end

		respond_to { |format| format.js }
	end

	# *** admin ***

	def index
		@orders = Order.all
	end

	private

	def owner_or_admin(order)
		return current_user.order == order || current_user.is_admin?
	end

	def authenticate_admin
		unless current_user.is_admin?
			flash[:error] = "You're not allowed to see this :("
			redirect_to root_path
		end
	end
end
