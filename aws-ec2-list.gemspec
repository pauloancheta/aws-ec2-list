# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_ec2_list/version'

Gem::Specification.new do |spec|
  spec.name          = "aws-ec2-list"
  spec.version       = AwsEc2List::VERSION
  spec.authors       = ["pauloancheta"]
  spec.email         = ["paulo.ancheta@gmail.com"]

  spec.summary       = %q{list all your ec2 instances}
  spec.description   = %q{list all ec2 instances}
  spec.homepage      = "https://github.com/pauloancheta/aws-ec2-list"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_dependency "virtus", "~> 1.0"
  spec.add_dependency "tabularize", '~> 0.2.10'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
