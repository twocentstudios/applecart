class AdminController < ApplicationController
	before_filter :authenticate_admin

	def dashboard
		@items = Item.all
	end
	
end
