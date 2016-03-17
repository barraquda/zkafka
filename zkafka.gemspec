# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zkafka/version'

Gem::Specification.new do |spec|
  spec.name          = "zkafka"
  spec.version       = Zkafka::VERSION
  spec.authors       = ["Shohei Miyashita"]
  spec.email         = ["shohei.miyashita@kamasu.jp"]

  spec.summary       = %q{Kafka with Zookeeper managing}
  spec.description   = %q{Kafka with using Zookeeper as the cluster manager}
  spec.homepage      = "http://github.com/barraquda/zkafka"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'zk', "~> 1.9.6"
  spec.add_runtime_dependency 'ruby-kafka', "~> 0.3.2"
end
