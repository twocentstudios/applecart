class AdminController < ApplicationController
	before_filter :authenticate_admin

	def dashboard
		@items = Item.all
	end

	def toggle_sale
		Settings.sale_enabled = !Settings.sale_enabled
		redirect_to admin_dashboard_path
	end
	
end
