class OrdersController < ApplicationController
	before_filter :authenticate_user!

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

	end

	def update

	end

	private

	def owner_or_admin(order)
		return current_user.order == order || current_user.is_admin?
	end
end
