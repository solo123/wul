module ApplicationHelper
	ALERT_TYPES = [:error, :info, :success2, :warning]

	def bootstrap_flash
		flash_messages = []
		flash.each do |type, message|
			next if message.blank?

			type = :success2 if type == :notice
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
    dict = {
        "/invests" => "invest",
        "/usercenter" => "account",
        "/about" => "about",
        "/fixed_deposits" => "invest",
        "/month_deposits" => "invest",
    }
	  menu_key = 'home'
    dict.each do |k,v|
      if request.path.start_with?(k)
        menu_key = v
      end
    end
		menu_key
	end
end
