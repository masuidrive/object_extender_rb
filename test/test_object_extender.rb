require 'test/unit'
require 'object_extender'

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
    extended do
      self.foo = :FooFoo
    end
  end

  module WithCallingExtendedAndExtendedClass
    extend ObjectExtender
    extended_class do
      attr_accessor :foo
    end
    extended do
      self.foo = :FooFooFoo
    end
  end

  def test_with_extended
    obj = Object.new
    assert_equal obj, obj.extend(WithCallingExtendedAndExtendedClass)
    assert_equal :FooFooFoo, obj.foo

    test_without_ext
  end

  def test_with_extended_and_extended_class
    obj = Object.new
    assert_equal obj, obj.extend(WithCallingClassMethod)
    assert_equal obj, obj.extend(WithCallingExtended)
    assert_equal :FooFoo, obj.foo

    test_without_ext
  end

  def test_with_multiple_extended
    obj = Object.new
    assert_equal obj, obj.extend(WithCallingExtendedAndExtendedClass)
    assert_equal obj, obj.extend(WithCallingExtended)
    assert_equal :FooFoo, obj.foo

    test_without_ext
  end

  def test_multiple_extended
    assert_raises(ObjectExtender::MultipleExtendedBlocks) do
      Module.new do
        extend ObjectExtender
        extended do
        end
        extended do
        end
      end
    end
  end

  def test_multiple_extended_class
    assert_raises(ObjectExtender::MultipleExtendedClassBlocks) do
      Module.new do
        extend ObjectExtender
        extended_class do
        end
        extended_class do
        end
      end
    end
  end
end
