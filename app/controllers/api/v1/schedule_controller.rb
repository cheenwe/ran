class Api::V1::ScheduleController < ApplicationController


	# GET /api/v1/schedule
	def index
		if params[:play_date]
			#搜索类型频道
			if params[:query_type] == "channel"

				@channels = QingtingApi.search("#{params[:query]}")["data"].first["doclist"]["docs"] rescue [""]
				# QingtingApi.search("盗墓笔记1")["data"].first["doclist"]["docs"]
				if params[:channel_id]

					page_size = params[:page_size]  rescue 30
					page = params[:page]  rescue 1
					@programs = QingtingApi.ondemand_channel(params[:channel_id], page, page_size)["data"]  rescue [""]
				else

				end

			#搜索节目
			elsif params[:query_type] == "program"

				@programs = QingtingApi.search("#{params[:query]}","program_ondemand")["data"].last["doclist"]["docs"] rescue [""]
				# @api_v1_qingting_programs = QingtingApi.search("盗墓笔记1","program_ondemand")["data"].last["doclist"]["docs"] rescue [""]

			else

			end
			@playlists = System.new.playlists(params[:play_date])["collects"]
		else
			render "_chose_date"
		end
	end

	def new

		if params[:action_type] == "create"&&params[:program_ids]
			if info = System.new.addplaylists(params[:program_ids],params[:play_date])
				redirect_to :back,  notice: "批量插播成功,请查看右边栏目"
			else
				redirect_to :back,  notice: t("other_error")
			end
		elsif params[:action_type] == "create"
			if info = System.new.addplaylist(params[:id],params[:play_date])
				redirect_to :back,  notice: info
			else
				redirect_to :back,  notice: t("other_error")
			end
		elsif  params[:action_type] == "remove"
			if info = System.new.deleteplaylists(params[:id],params[:play_date])
				redirect_to :back,  notice: info
			else
				redirect_to :back,  notice: t("other_error")
			end
		else
			redirect_to :back,  notice: t("other_error")

		end
	end



end
