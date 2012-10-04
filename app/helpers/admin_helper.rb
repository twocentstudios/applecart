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

	def mail_to_all
		return mail_to_button_from_users(User.all)
	end

	def mail_to_open
		return mail_to_button_from_users(User.users_with_open_order)
	end

	def mail_to_processing
		return mail_to_button_from_users(User.users_with_processing_order)
	end

	def mail_to_unpaid_processing
		return mail_to_button_from_users(User.users_with_unpaid_processing_order)
	end

	def mail_to_paid_processing
		return mail_to_button_from_users(User.users_with_paid_processing_order)
	end

	def mail_to_delivered
		return mail_to_button_from_users(User.users_with_delivered_order)
	end

	def mail_to_button_from_users(user_array)
		return mail_to "", "email", :bcc => concat_emails_from_array(user_array), :class => 'btn btn-small'
	end

	def concat_emails_from_array(user_array)
		all_emails = ""
		user_array.each do |user|
			all_emails << "\"#{user.name}\" <#{user.email}>,"
		end
		all_emails[-1] = ""
		return all_emails
	end
end
