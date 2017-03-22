# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'house_floor_bills/version'

Gem::Specification.new do |spec|
  spec.name          = "house_floor_bills"
  spec.version       = HouseFloorBills::VERSION
  spec.date          = "2017-03-22"
  spec.authors       = ["Dalma Boros"]
  spec.email         = ["dalma.boros@gmail.com"]

  spec.summary       = %q{Bills to be considered on the house floor.}
  spec.description   = %q{Bills scheduled for debate this week on the House of Representatives floor.}
  spec.homepage      = "https://github.com/dalmaboros/house-floor-bills-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ["house-floor-bills"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
end
