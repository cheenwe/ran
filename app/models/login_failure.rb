class LoginFailure < ActiveRecord::Base

	scope :matching, lambda { |request|
	  where(name: request.params[:user][:name], ip: request.remote_ip,user_agent:request.params[:user][:user_agent].to_s.downcase).where('created_at >= ?', 15.minutes.ago)

	}
end
