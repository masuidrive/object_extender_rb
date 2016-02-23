require 'test/unit'
require 'object_extender'

# https://github.com/rails/rails/blob/d06e42518a4fdd1732f1d75a43c69071bcd79245/activesupport/test/concern_test.rb

class ObjectExtenderTest < Test::Unit::TestCase
  def test_without_ext
    obj = Object.new
    assert_raise NoMethodError do
      obj.foo
    end
    assert_raise NoMethodError do
      obj.bar
    end
  end

  module WithCallingClassMethod
    extend ObjectExtender
    extended_class do
      attr_accessor :foo
    end
  end

  def test_with_calling_class_method
    obj = Object.new
    assert_equal obj, obj.extend(WithCallingClassMethod)
    assert_nil obj.foo
    obj.foo = :Foo
    assert_equal :Foo, obj.foo

    test_without_ext
  end

  module WithDefineMethod
    extend ObjectExtender
    def bar
      :Bar
    end
  end

  def test_with_define_method
    obj = Object.new
    assert_equal obj, obj.extend(WithDefineMethod)
    assert_equal :Bar, obj.bar

    test_without_ext
  end

  module WithCallingExtended
    extend ObjectExtender
    extended_class do
      attr_accessor :foo
    end
    extended do
      self.foo = :FooFoo
    end
  end

  def test_with_extended
    obj = Object.new
    assert_equal obj, obj.extend(WithCallingExtended)
    assert_equal :FooFoo, obj.foo

    test_without_ext
  end
end
