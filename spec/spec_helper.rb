$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "aws_ec2_list"
require "aws_ec2_list/parse_option"
require "aws_ec2_list/describe_instances"

require_relative "support/ec2_double"
require_relative "support/io_double"
