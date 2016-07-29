class LoginFailure < ActiveRecord::Base
  scope :matching, lambda { |request|
    where(name: request.params[:user][:name], ip: request.remote_ip,user_agent:request.user_agent.to_s.downcase).where('created_at >= ?', Setting.login_failure_lock_minute.minutes.ago)
  }
end
