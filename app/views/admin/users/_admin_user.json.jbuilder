json.extract! admin_user, :id, :uid, :email, :name, :english_name, :avatar, :state, :type, :bio, :created_at, :updated_at
json.url admin_user_url(admin_user, format: :json)
