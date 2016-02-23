lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_extender/version'

Gem::Specification.new do |spec|
  spec.name          = 'object_extender'
  spec.version       = ObjectExtender::VERSION
  spec.authors       = ['Yuichiro MASUI']
  spec.email         = 'masui@masuidrive.jp'
  spec.summary       = %(Call class statements with extended object. It's without class pollution.)
  spec.description   = %(Call class statements with extended object. It's without class pollution.)

  spec.homepage      = 'https://github.com/masuidrive/object_extender_rb'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 1.9.2'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
end
