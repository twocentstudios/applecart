module OrderHelper

	def paid(order)
		if order.paid?
			return content_tag 'h3', "paid", :class => 'paid'
		else
			return content_tag 'h3', "not paid", :class => 'not-paid'
		end
	end

	def edit_action(order)
		if order.state == 'open'
			return link_to 'Edit Order', edit_order_path(@order), :class => 'btn btn-large btn-info'
		end
	end

	def submit_action(order)
		if order.state == 'open'
			return link_to 'Submit Order', '#', :class => 'btn btn-large btn-primary'
		end
	end

	def order_paid_action(order)
		if current_user.is_admin?
			if order.paid?
				return link_to 'Payment Received', '#', :class => 'btn btn-large btn-success'
			end
		end
	end

	def edit_order_title(order)
		if current_user.is_admin?
			return "Edit Order for " + order.user.name
		else
			return "Edit My Order"
		end
	end
end
