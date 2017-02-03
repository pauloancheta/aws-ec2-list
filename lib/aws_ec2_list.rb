require "aws_ec2_list/version"
require 'virtus'
require 'aws-sdk'
require 'tabularize'

module AwsEc2List
  def self.call(passed_options, options)
    args = passed_options.split(" ").map do |option|
      key, value = option.split("=")
      {key.gsub("--", "").to_sym => value}
    end

    Runner.new(options.merge(*args)).call
  end
end

require_relative "aws_ec2_list/runner"
