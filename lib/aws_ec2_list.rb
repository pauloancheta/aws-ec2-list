require "aws_ec2_list/version"
require 'virtus'
require 'aws-sdk'
require 'tabularize'

module AwsEc2List
  def self.call(*args)
    Runner.new(*args).call
  end
end

require_relative "aws_ec2_list/runner"
