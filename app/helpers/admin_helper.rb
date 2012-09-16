module AdminHelper
	def sale_status_badge
		if Settings.sale_enabled == true
			return content_tag :span, 'open', :class => 'label label-success'
		else
			return content_tag :span, 'closed', :class => 'label label-important'
		end
	end

	def sale_status_action
		if Settings.sale_enabled == true
			return link_to 'Close Sale', admin_toggle_sale_path, :class => 'btn btn-danger', :method => 'POST', :confirm => 'Are you sure you want to stop accepting new orders?'
		else
			return link_to 'Open Sale', admin_toggle_sale_path, :class => 'btn btn-success', :method => 'POST', :confirm => 'Are you sure you want to start accepting new orders?'
		end
	end
end
