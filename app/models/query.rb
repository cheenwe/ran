class Query < ActiveRecord::Base
  belongs_to :user
  serialize :filters





def build_from_params(params)
	if params[:filters]
		params[:filters].each do |filter|
			add_filter(filter["feild"],filter["operator"],filter["value"])
		end

	else

	end

end

def self.add_filter(feild, operator,value)
	s = "#{feild}"+"_"+"#{operator}"
	filters[:s] = value
	puts filters
end

end
