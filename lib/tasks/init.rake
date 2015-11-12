namespace :db do
	desc 'init app'
	task :init do
		puts 'Creating database... '
		system 'bundle exec rake db:create'
		system 'bundle exec rake db:migrate'

		puts "\n"
		print 'Creating config/secrets.yml... '
		secret_token = Rails.root.join('config', 'secrets.yml')

		# Only create if it doesn't exit yet
		if !File.exists?(secret_token)
			File.open(secret_token, 'w') do |f|
				%w{development test production}.each do |env|
					f.write "#{env}:\n"
					f.write "  secret_key_base: #{SecureRandom.hex(64)}\n"
				end
			end
			puts 'OK'
		else
			puts "\n"
			puts 'config/secrets.yml already exists'
		end

		puts "\n"
		puts 'init succesfully.'
		puts "\n"
	end
	desc 'create users'
	task :load_demo_data => :environment do
		# admin = User.create(:email => 'admin@qq.com', :password => '123123123', :password_confirmation => '123123123', :admin => true)
		# demo = User.create(:email => 'demo@qq.com', :password => '123123123', :password_confirmation => '123123123')

	end
end


