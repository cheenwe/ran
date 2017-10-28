
class Settings < RailsSettings::Base
  source Rails.root.join("#{Rails.root}/config/istar.yml")
  namespace Rails.env
  SEPARATOR_REGEXP = /[\s,]/

  class << self

    def base_url
      [self.protocol, self.host_name].join("://")
    end

    def has_admin?(email)
      return false if self.admin_emails.blank?
      self.admin_emails.split(SEPARATOR_REGEXP).include?(email)
    end

    def gitlab_on_standard_port?
      on_standard_port?(gitlab)
    end

    def host_without_www(url)
      host(url).sub('www.', '')
    end

    # check that values in `current` (string or integer) is a contant in `modul`.
    def verify_constant_array(modul, current, default)
      values = default || []
      unless current.nil?
        values = []
        current.each do |constant|
          values.push(verify_constant(modul, constant, nil))
        end
        values.delete_if { |value| value.nil? }
      end
      values
    end

    # check that `current` (string or integer) is a contant in `modul`.
    def verify_constant(modul, current, default)
      constant = modul.constants.find { |name| modul.const_get(name) == current }
      value = constant.nil? ? default : modul.const_get(constant)
      if current.is_a? String
        value = modul.const_get(current.upcase) rescue default
      end
      value
    end

    def absolute(path)
      File.expand_path(path, Rails.root)
    end

    private

    def on_standard_port?(config)
      config.port.to_i == (config.https ? 443 : 80)
    end

    # Extract the host part of the given +url+.
    def host(url)
      url = url.downcase
      url = "http://#{url}" unless url.start_with?('http')

      # Get rid of the path so that we don't even have to encode it
      url_without_path = url.sub(%r{(https?://[^\/]+)/?.*}, '\1')

      URI.parse(url_without_path).host
    end

    # Runs every minute in a random ten-minute period on Sundays, to balance the
    # load on the server receiving these pings. The usage ping is safe to run
    # multiple times because of a 24 hour exclusive lock.
    def cron_for_usage_ping
      hour = rand(24)
      minute = rand(6)

      "#{minute}0-#{minute}9 #{hour} * * 0"
    end
  end
end
