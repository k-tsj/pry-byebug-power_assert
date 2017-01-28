# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry/byebug/power_assert/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-byebug-power_assert"
  spec.version       = Pry::Byebug::PowerAssert::VERSION
  spec.authors       = ["Kazuki Tsujimoto"]
  spec.email         = ["kazuki@callcc.net"]

  spec.summary       = %q{Extend pry-byebug with power_assert}
  spec.description   = %q{pry-byebug-power_assert shows Power Assert style inspection message when you run 'next' command of pry-byebug.}
  spec.homepage      = "https://github.com/k-tsj/pry-byebug-power_assert"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "pry-byebug"
   spec.add_development_dependency "power_assert", ">= 1.0.0"
  spec.extra_rdoc_files = ['README.md']
  spec.rdoc_options     = ['--main', 'README.md']
  spec.licenses         = ['2-clause BSDL', "Ruby's"]
end
