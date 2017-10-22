# require 'stomp'

class System

  ZERO = '0.0'.to_d
  NOTHING_ARRAY = YAML::dump([])

  LIMIT = 80

  class << self
    IS_VALIDATE = [
      {name: 'email', regexp: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/},
      {name: 'phone', regexp: /^1\d{10}$/},
    ]

    # "^\d+$"　　//非负整数（正整数 + 0）
    # "^[0-9]*[1-9][0-9]*$"　　//正整数
    # "^((-\d+)|(0+))$"　　//非正整数（负整数 + 0）
    # "^-[0-9]*[1-9][0-9]*$"　　//负整数
    # "^-?\d+$"　　　　//整数
    # "^\d+(\.\d+)?$"　　//非负浮点数（正浮点数 + 0）
    # "^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$"　　//正浮点数
    # "^((-\d+(\.\d+)?)|(0+(\.0+)?))$"　　//非正浮点数（负浮点数 + 0）
    # "^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$"　　//负浮点数
    # "^(-?\d+)(\.\d+)?$"　　//浮点数
    # "^[A-Za-z]+$"　　//由26个英文字母组成的字符串
    # "^[A-Z]+$"　　//由26个英文字母的大写组成的字符串
    # "^[a-z]+$"　　//由26个英文字母的小写组成的字符串
    # "^[A-Za-z0-9]+$"　　//由数字和26个英文字母组成的字符串
    # "^\w+$"　　//由数字、26个英文字母或者下划线组成的字符串
    # "^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$"　　　　//email地址
    # "^[a-zA-z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$"　　//url

    # 正则表达式--验证手机号码:1[3|5|7|8|][0-9]{9}
    # 实现手机号前带86或是+86的情况:^((\+86)|(86))?(13)\d{9}$
    # 电话号码与手机号码同时验证:(^(\d{3,4}-)?\d{7,8})$|(13[0-9]{9})
    # 提取信息中的网络链接:(h|H)(r|R)(e|E)(f|F)  *=  *('|")?(\w|\\|\/|\.)+('|"|  *|>)?
    # 提取信息中的邮件地址:\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
    # 提取信息中的图片链接:(s|S)(r|R)(c|C)  *=  *('|")?(\w|\\|\/|\.)+('|"|  *|>)?
    # 提取信息中的IP地址:(\d+)\.(\d+)\.(\d+)\.(\d+)
    # 提取信息中的中国手机号码:(86)*0*13\d{9}
    # 提取信息中的中国固定电话号码:(\(\d{3,4}\)|\d{3,4}-|\s)?\d{8}
    # 提取信息中的中国电话号码（包括移动和固定电话）:(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}
    # 提取信息中的中国邮政编码:[1-9]{1}(\d+){5}
    # 提取信息中的中国身份证号码:\d{18}|\d{15}
    # 提取信息中的整数：\d+
    # 提取信息中的浮点数（即小数）：(-?\d*)\.?\d+
    # 提取信息中的任何数字  ：(-?\d*)(\.\d+)?
    # 提取信息中的中文字符串：[\u4e00-\u9fa5]*
    # 提取信息中的双字节字符串  (汉字)：[^\x00-\xff]*

    def is_email(name)
      name  =~ /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
    end

    # System.is_phone(1851605376)
    # System.is_phone(18516053764)
    def is_phone(name)
      name  =~  /^1\d{10}$/
    end

    def is_email?(name)
      is_email(name) == 0
    end

    # System.is_phone(1851605376)
    # System.is_phone(18516053764)
    def is_phone?(name)
      is_phone(name) == 0
    end

    def today
      now.strftime("%Y-%m-%d")
    end

    def time
      now.strftime("%Y-%m-%d %H:%M:%S")
    end

    def now
      Time.now
    end

    def now_s
      now.strftime("%y%m%d%H%M%S")
    end


    # fill
    def billdetails_sn
      (now_s + column_cache_count("billdetails_sn").rjust(11, '0')) rescue (Billdetail.last.sn.succ rescue 1)
    end

    def recharges_sn
      (now_s + column_cache_count("recharges_sn").rjust(8, '0')) rescue (Recharge.last.sn.succ rescue 1)
    end


    # 100_000_000.times.map { |e| System.column_cache_count  }
    # System.column_cache_count()
    def column_cache_count(column_name)
      tmp_sn = readed(column_name)
      i = tmp_sn.present? ? tmp_sn:1
      i = i.succ
      cached(column_name, i)
      return i
    end

    def cached(name, value)
      $redis.set(name, value)
    end

    # System.readed('billdetails_sn')
    def readed(name)
      $redis.get(name)
    end

    # 当前请求时间戳小于 60 秒内允许请求
    def check_request(at)
      Time.now.to_i - (at.to_i/3.14) < 60000
    end

    # 加密密码
    def encode_password()

    end

    # 解密密码
    #  base64 解密后 去除后 5位
    def decode_password(data)

      p "*password"*10
      p Base64.decode64(data)[0..-6]
      p "*password"*10

      Base64.decode64(data)[0..-6]
    end

    # Base64.encode64('chenwei12345')[0..-6]

    def channel
      "market-global"
    end

    def ip_to_i(ip)
      IPAddr.new(ip).to_i
    end

    def daemon_statuses
      Rails.cache.fetch('daemons:statuses', expires_in: 3.minute) do
        Daemons::Rails::Monitoring.statuses
      end
    end

    def uuid
      return SecureRandom.uuid.gsub('-', '')
    end

    # Global.test_mq

    # Global.send_mq(name, result)

    # def test_mq
    #   result = { "message_type":"suspect_lib_update" }
    #   Global.send_mq('detective_response', result)
    # end

    # def send_mq(name, message)
    #   @stomp_client = Stomp::Client.new("", "", "#{Setting.message_queue_host}", 61613)
    #   @stomp_client.publish("/queue/#{name}",message)
    # end

    def number(n)
      (1..n).collect {self.digit}.join
    end

    def string(n)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      string = ""
      1.upto(n) { |i| string << chars[rand(chars.size-1)] }
      return string
    end

    def sms_api_key
      Setting.sms_api_key
    end
    def sms_api_url
      URI(Setting.sms_api_post_url)
    end

    def send_sms(phone, data)
      params = {
        'apikey': sms_api_key,
        'text': data,
        'mobile':phone
      }
      post_request(sms_api_url, params)
    end

    def post_request(uri, params)
      res = Net::HTTP.post_form(uri, params)
      res.body
    end

  end



  # Generate.encode()
  # Generate.decode()
  def self.encode code
    "#{ self.number 5}" + "#{code}"
  end


  def self.decode code
    code[5..18]
  end


  def self.digit
    (rand() * 9).round.to_s
  end
  def default_ticker
    {low: ZERO, high: ZERO, last: ZERO, volume: ZERO}
  end

  def at
    @at ||= DateTime.now.to_i
  end
end
