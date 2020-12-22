# frozen_string_literal: true

require_relative 'accessors'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validates

    def validate(variable_name, validate_type, optional_parameter = nil)
      @validates ||= []
      @validates.push([variable_name, validate_type, optional_parameter])
    end
  end

  module InstanceMethods
    def validate_presence(name, _optional_parameter = nil)
      variable = instance_variable_get("@#{name.to_sym}")
      raise "Исключение. #{name} = #{variable.inspect}" if variable.nil? || variable == ''
    end

    def validate_format(name, regex)
      variable = instance_variable_get("@#{name.to_sym}")
      raise "#{name} не соответствует регулярному выражению" unless variable.match(regex)
    end

    def validate_type(name, type)
      variable = instance_variable_get("@#{name.to_sym}")
      raise "Ожидал #{type}, а у #{name} тип #{variable.class}" if variable.class != type
    end

    def validate!
      self.class.validates.each do |element|
        variable_name = element[0]
        validate_type = element[1]
        optional_parameter = element[2]
        send("validate_#{validate_type}", variable_name, optional_parameter)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

# Код для проверки
#
# class ValTest
#   include Validation
#
#   attr_accessor :age
#
#   def initialize(value)
#     @age = value
#     @name = 'привет'
#     @iq = 15
#     self.class.validate(:iq, :presence)
#     self.class.validate(:iq, :type, Integer)
#     self.class.validate(:age, :type, Integer)
#     self.class.validate(:name, :format, /^привет/)
#     validate!
#   end
# end
#
# t = ValTest.new(70)
