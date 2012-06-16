# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nourl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Artem Yankov"]
  gem.email         = ["artem.yankov@gmail.com"]
  gem.description   = %q{Simple lib to provide RPC interface to models}
  gem.summary       = %q{Simple lib to provide RPC interface to models}
  gem.homepage      = ""
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nourl"
  gem.require_paths = ["lib"]
  gem.version       = Nourl::VERSION
end
