# Object Extender Gem

[![Gem Version](https://badge.fury.io/rb/object_extender.svg)](https://badge.fury.io/rb/object_extender)
develop: [![Build Status](https://travis-ci.org/masuidrive/object_extender_rb.svg?branch=develop)](https://travis-ci.org/masuidrive/object_extender_rb)  master: [![Build Status](https://travis-ci.org/masuidrive/object_extender_rb.svg?branch=master)](https://travis-ci.org/masuidrive/object_extender_rb)

Call class statements with extended object.
It's without class pollution.

- https://github.com/masuidrive/object_extender_rb
- https://rubygems.org/gems/object_extender
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
