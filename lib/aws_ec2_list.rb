require "aws_ec2_list/version"
require 'virtus'
require 'aws-sdk'
require 'tabularize'

module AwsEc2List
  def self.call(passed_options, options)
    passed_options_array = passed_options.split(" ")

    args = passed_options_array.map do |option|
      key, value = option.split("=")
      key = key.gsub("--", "").to_sym
      {key => value}
    end

    Runner.new(options.merge(*args)).call
  end
end

require_relative "aws_ec2_list/runner"
