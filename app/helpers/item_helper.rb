module ItemHelper
	def add_apple_action(item, order)
		if order.open?
			link_to 'Add to cart', item_add_to_order_path(item), :class => 'btn btn-primary', :method => 'POST', :remote => true
		end
	end
end
