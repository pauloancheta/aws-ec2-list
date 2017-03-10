require "aws_ec2_list/version"
require 'virtus'
require 'aws-sdk'
require 'tabularize'

module AwsEc2List
  def self.call(*args)
    defaults = parse_args(args)
    if defaults
      DescribeInstances.new(defaults).call
    else
      DescribeInstances.new.call
    end
  end

  private
  def self.parse_args(args)
    return nil if args.empty?
    return args.first if args.first.is_a?(Hash)
    option_string, default_args = args

    option_string = option_string.first

    if option_string && default_args
      option_hash = option_string_to_hash(option_string)
      option_hash.merge(default_args)

    elsif option_string
      option_string_to_hash(option_string)

    end
  end

  def self.option_string_to_hash(option_string)
    option_array = option_string.split("--").reject { |o| o.empty? }
    option_array = option_array.map{ |opt| opt.split("=") }.flatten

    option_hash = Hash[*option_array]

    option_hash.keys.each do |key|
      option_hash[key.to_sym] = option_hash.delete(key)
    end

    option_hash
  end
end

require_relative "aws_ec2_list/describe_instances"
