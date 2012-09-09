module OrderHelper

	def empty_order(order)
		if order.order_items.empty?
			render 'empty_order'
		end
	end

	def paid(order)
		text = order.paid ? 'paid' : 'not paid'
		cls = order.paid? ? 'paid' : 'not-paid'
		content_tag 'h3', text, :class => cls, :id => 'paid-text'
	end

	def edit_action(order)
		if order.open? && order.order_items.present?
			return link_to 'Edit Order', edit_order_path(@order), :class => 'btn btn-large btn-info'
		end
	end

	def submit_action(order)
		if order.open? && order.order_items.present?
			return link_to 'Submit Order', order_submit_order_path(order), :class => 'btn btn-large btn-primary', :method => 'POST', :remote => true
		end
	end

	def order_paid_action(order)
		if current_user.is_admin?
			text = order.paid ? 'Payment Received' : 'Payment Not Received'
			cls = "btn btn-large " + (order.paid ? 'btn-success' : 'btn-danger')
			link_to text, order_toggle_paid_path(order), :class => cls, :id => 'btn-paid', :method => 'POST', :remote => true
		end
	end

	def edit_order_title(order)
		if current_user.is_admin?
			return "Edit Order for " + order.user.name
		else
			return "Edit My Order"
		end
	end

	def paid_toggle_cell(order)
		text = order.paid ? 'yes' : 'no'
		td_cls = order.paid ? 'cell-paid' : 'cell-not-paid'
		content_tag 'td', link_to(text, order_toggle_paid_path(order), :class => 'btn btn-small', :id => "btn-paid-#{order.id}", :title => "toggle paid", :method => 'POST', :remote => true), :class => td_cls, :id => "cell-paid-#{order.id}"
	end

	def status_toggle_cell(order)
		if order.open?
			text = 'open'
			td_cls = 'cell-status-open'
		elsif order.processing?
			text = 'processing'
			td_cls = 'cell-status-processing'
		elsif order.delivered?
			text = 'delivered'
			td_cls = 'cell-status-delivered'
		end
		content_tag 'td', link_to(text, order_toggle_status_path(order), :class => 'btn btn-small', :id => "btn-status-#{order.id}", :title => "next status", :method => 'POST', :remote => true), :class => td_cls, :id => "cell-status-#{order.id}"
	end
end
