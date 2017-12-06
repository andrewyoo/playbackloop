# this adds enum capibilities to an active record model
# http://jeffkreeftmeijer.com/2011/microgems-five-minute-rubygems/
module ActiveRecordSimpleEnum
  extend ActiveSupport::Concern

  module ClassMethods
    # how to define an enum on a model
    # For example: simple_enum :color, %i[ blue purple red green ]
    # pass prefix: true to prefix the ? methods with attribute name, e.g. color_green?
    def simple_enum(attribute, choices, options = {})
      prefix = options[:prefix] ? "#{attribute}_" : ''

      # add an 'attributes' method, e.g. User.colors
      define_singleton_method(:"#{attribute.to_s.pluralize}") { choices }

      # add 'choice?' methods, e.g. blue?
      # add scope methods, e.g. Shirt.blue
      choices.each do |choice|
        define_method(:"#{prefix}#{choice}?") { send(attribute) == choice.to_s }

        class_eval do
          scope "#{prefix}#{choice}", -> { where(table_name => { attribute => choice }) }
        end
      end
    end
  end
end
ActiveRecord::Base.send(:include, ActiveRecordSimpleEnum)
