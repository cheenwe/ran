class Query < ActiveRecord::Base
  belongs_to :user, class_name: "User"

  serialize :filters
  attr_accessor :field, :operator, :value, :records

  def records
    {
    field:nil,
    operator:nil,
    value:nil
    }
  end

  def build_from_params(params)
    if params
      # params.each do |filter|
        add_filter(params["field"],params["operator"],params["value"])
      # end
    else
    end
  end

  def add_filter(field, operator,value)

    puts ">>>>>>>>>>>>>>>>#{field},,,,,,,,,,,,,,,,,,,,,,,#{operator}>>>>>>>>>>>>>>>>>#{value}"
    s = "#{field}"+"_"+"#{operator}"
    filters={}
    filters[:"#{s}"] = value

    self.filters = filters
    self.save

  end

  def self.sign
   [
    {name: I18n.t(:"query.cont"), value: "cont" },
    {name: I18n.t(:"query.not_contains"),value: "not_contains"},
    {name: I18n.t(:"query.equals"),value: "eq"},
    {name: I18n.t(:"query.not_equals"),value: "not_eq"},
    {name: I18n.t(:"query.less_than"),value: "lt"},
    {name: I18n.t(:"query.greater_than"),value: "gt"},
    {name: I18n.t(:"query.less_than_or_equal_to"),value: "lteq"},
    {name: I18n.t(:"query.greater_than_or_equal_to"),value: "gteq"},
    {name: I18n.t(:"query.start_with"),value: "start"},
    {name: I18n.t(:"query.not_start_with"),value: "not_start"},
    {name: I18n.t(:"query.end_with"),value: "end"},
    {name: I18n.t(:"query.not_end_with"),value: "not_end"},
    {name: I18n.t(:"query.is_null"),value: "null"},
    {name: I18n.t(:"query.not_null"),value: "not_null"}
  ]
  end

end
