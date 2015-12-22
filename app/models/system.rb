# encoding: utf-8
require 'net/http'
require 'active_support/json'

class System

    def access_token
      a = post 'sessions', phone: Setting.phone, password:Setting.password
      a['sessionid']
    end

    #通过id进行多次排播
    def addplaylists(program_ids, play_date)
      post '/api/v1/fmplaylists', sessionid: System.new.access_token, program_ids: program_ids, play_date: play_date, collect_type:"playlist"
    end

    #节目排播
    def addplaylist(program_id, play_date)
      post '/api/v1/fmplaylists', sessionid: System.new.access_token, program_id: program_id, play_date: play_date, collect_type:"playlist"
    end

    #获取排播列表
    def playlists(play_date)
      get "/fm/playlists?sessionid=#{ System.new.access_token}&play_date=#{play_date}"
    end

    #删除排播节目
    def deleteplaylists(program_id, play_date)
      delete "/api/v1/fmplaylists/1?sessionid=#{ System.new.access_token}&play_date=#{play_date}&program_id=#{program_id}"
    end

    #添加分类
    def addcategories(media_id, id, name, sequence, section_id, category_type)
      post '/api/v1/fmcategories', sessionid: System.new.access_token, media_id:media_id,  id:id,  name:name,  sequence:sequence,  section_id:section_id,  category_type:category_type
    end

     #获取分类
    def categories
      get "/fm/categories?sessionid=#{ System.new.access_token}"
    end

    #删除分类
    def deletecategories(category_id)
      delete "/api/v1/fmcategories/1?sessionid=#{ System.new.access_token}&category_id=#{category_id}"
    end


    #添加频道
    def addchannels(channel_id)
      post '/api/v1/fmchannels', sessionid: System.new.access_token, channel_id:channel_id
        # if info = System.new.addchannels(params["category_id"],params["channel_id"])
    end

     #获取频道
    def channels(category_id, page, per_page)
      get "/api/v1/fmchannels?sessionid=#{ System.new.access_token}&category_id=#{category_id}&page=#{page}&per_page=#{per_page}"
    end

    #删除频道
    def deletechannels(channel_id)
      delete "/api/v1/fmchannels/1?sessionid=#{ System.new.access_token}&channel_id=#{channel_id}"
    end

    def post(api, options = {})
      uri = URI.join(Setting.api_url, api)
      res = Net::HTTP.post_form(uri, options)
      result res.body
    end

    def get(api, options = {})
      url = URI.join(Setting.api_url, api)
      result Net::HTTP.get(url)
    end

    def delete(api, options = {})

      url = URI.join(Setting.api_url, api)
      http = Net::HTTP.new(url.host, url.port)
      req = Net::HTTP::Delete.new(url)

      res = http.request(req)
      {"headcode"=>200, "message"=>"删除成功"}
    end


    def result(body)
      begin
       result =  ActiveSupport::JSON.decode body
      rescue => e
        {
          code: 502,
          msg: '内容解析错误',
          detail: e.to_s
        }
      end
    end

end