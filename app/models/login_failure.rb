class LoginFailure < ActiveRecord::Base

	scope :matching, lambda { |request|
		puts ">>>>>>>>>>>>>>>#{request.user_agent}"
	  where(name: request.params[:user][:name].downcase, ip: request.remote_ip,user_agent:request.params[:user][:user_agent].to_s.downcase).where('created_at >= ?', 15.minutes.ago)

	}
end
