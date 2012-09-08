module OrderHelper
	def paid(order)
		if order.paid?
			return content_tag 'h3', "paid", :class => 'paid'
		else
			return content_tag 'h3', "not paid", :class => 'not-paid'
		end
	end
end
