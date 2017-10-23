module OmniauthCallbacks
  extend ActiveSupport::Concern

  module ClassMethods
    %w(weibo qq github weichat).each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|

        uid = response['uid'].to_s
        data = response['info']

        if (user = Authorization.find_by(provider: provider, uid: uid).try(:user))
          user
        else
          user = User.new_from_provider_data(provider, uid, data)

          if user.save(validate: false)

            user.update(confirmed_at: Time.now) #auto active user

            Authorization.find_or_create_by(provider: provider, uid: uid, user_id: user.id)
            return user
          else
            Rails.logger.warn("User.create_from_hash errors ，#{user.errors.inspect}")
            return nil
          end
        end
      end
    end

    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        user.email =
          if data['email'].present? && !User.where(email: data['email']).exists?
            data['email']
          else
            "#{provider}+#{uid}@#{Istar.config.host_name}"
          end
        puts  data
        if provider == 'github'
          user.name = data['name']
          user.username = data['nickname']
          user.username.gsub!(/[^\w]/, '_')
        elsif provider == 'weibo'
          user.name = data['info']['name']
          user.username = data['info']['nickname']
          user.username.gsub!(/[^\w]/, '_')

        end

        if user.name.blank?
          user.name = "u#{Time.now.to_i}"
        end

        if User.where(name: user.name).exists?
          user.username = "#{user.name}-#{provider}"
        end

        user.password = Devise.friendly_token[0, 20]
        # user.location = data['location']
        user.bio  = data['description']
      end
    end
  end
end


