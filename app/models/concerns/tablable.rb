module Concerns
  module Tablable
    extend ActiveSupport::Concern
    included do
      def self.table_attr(*args)
        @table_attrs = {}
        args.each do |arg|
          @table_attrs[arg] = self.human_attribute_name(arg)
        end
      end

      def self.table_attrs
        @table_attrs
      end
    end
  end
end
