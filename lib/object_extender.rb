# This module is `ActiveSupport::Concern` for instance.
#
# module Foo
#   extend ObjectExtender
#   extended_class do
#     attr_accessor :bar
#   end
#   extended do
#     puts :extended
#   end
#   def foo; p @bar; end
# end
#
# obj = Object.new.extend(Foo)
# obj.bar = :Foo
# obj.foo
#
# References:
# - https://github.com/rails/rails/blob/master/activesupport/lib/active_support/concern.rb
#
require "object_extender/version"

module ObjectExtender
  class MultipleExtendedClassBlocks < StandardError #:nodoc:
    def initialize
      super "Cannot define multiple 'extended_class' blocks"
    end
  end

  class MultipleExtendedBlocks < StandardError #:nodoc:
    def initialize
      super "Cannot define multiple 'extended' blocks"
    end
  end

  def extended(obj = nil, &block)
    if obj.nil?
      fail MultipleExtendedBlocks if instance_variable_defined?(:@_extended_block)
      @_extended_block = block
    else
      if instance_variable_defined?(:@_extended_class_block)
        obj.singleton_class.class_eval(&@_extended_class_block)
      end
      if instance_variable_defined?(:@_extended_block)
        obj.instance_eval(&@_extended_block)
      end
    end
  end

  def extended_class(&block)
    fail MultipleExtendedClassBlocks if instance_variable_defined?(:@_extended_class_block)
    @_extended_class_block = block
  end
end
