# class Settings < Settingslogic
#   source "#{Rails.root}/config/setting.yml"
#   namespace Rails.env
# end

# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join('config/setting.yml')

  class << self
    def protocol
      self.https == true ? 'https' : 'http'
    end
  end
end
