require "aws_ec2_list/version"
require 'virtus'
require 'aws-sdk'
require 'tabularize'

module AwsEc2List
  def self.call(*args)
    defaults = ParseOption.new(args: args).call
    DescribeInstances.new(defaults).call
  end
end

require_relative "aws_ec2_list/describe_instances"
require_relative "aws_ec2_list/parse_option"
