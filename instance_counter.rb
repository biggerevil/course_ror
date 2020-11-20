# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance_counter

    def instances
      @instance_counter
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_counter = 0 if self.class.instance_counter.nil?
      self.class.instance_counter += 1
    end
  end
end
