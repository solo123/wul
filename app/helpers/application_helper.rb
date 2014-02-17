module ApplicationHelper
	ALERT_TYPES = [:error, :info, :success, :warning]

	def bootstrap_flash
		flash_messages = []
		flash.each do |type, message|
			next if message.blank?

			type = :success if type == :notice
			type = :error   if type == :alert
			next unless ALERT_TYPES.include?(type)

			Array(message).each do |msg|
				text = content_tag(:div,
													 content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
													 msg.html_safe, :class => "alert fade in alert-#{type}")
				flash_messages << text if msg
			end
		end
		flash_messages.join("\n").html_safe
	end

	def current_main_menu
	  menu_key = 'home'
		if request.path.start_with?('/invests') 
			menu_key = 'invest'
		elsif request.path.start_with?('/account')
			menu_key = 'account'
		elsif request.path.start_with?('/about')
			menu_key = 'about'
		end
		menu_key
	end
end
