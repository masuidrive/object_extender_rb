# Object Extender Gem

Call class statements with extended object.

- http://github.com/masuidrive/object_extender_rb
- License: MIT
- Author: Yuichiro MASUI <masui@masuidrive.jp>


## Getting Started

```
require 'object_extender'

module AddFooAssoc
  extend ObjectExtender

  extended_class do
    attr_accessor :foo
  end

  extended do
    self.foo = :Foo
  end
end

obj = Object.new
# obj.foo = :Foo  => NoMethodError

obj.extend(AddFooAssoc)
obj.foo
obj.foo = :Bar

# Same as
obj = Object.new
obj.singleton_class.class_eval do
  attr_accessor :foo
end
obj.foo = :Bar
```
