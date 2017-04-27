require "spec_helper"
require_relative 'aws_ec2_list/ec2_double'
require_relative 'aws_ec2_list/io_double'

describe AwsEc2List do
  let(:stdout) { AwsEc2List::IODouble.new }
  let(:ec2) { AwsEc2List::Ec2Double }
  let(:region) { 'us-west-1' }

  def output
    """project | stack_name        | public_dns_name | launch_time | app_version | state
webapp  | lp-webapp-prod-01 | public_dns_name | launch_time | 123h12kj    | state"""
  end

  it "has a version number" do
    expect(AwsEc2List::VERSION).not_to be nil
  end

  it "returns the instances" do
    AwsEc2List.call(ec2: ec2, region: region, stdout: stdout)
    expect(stdout.to_s).to eq output
  end

  it "returns the instances given a string" do
    AwsEc2List.call(["--region=us-east-1"], ec2: ec2, stdout: stdout)
    expect(stdout.to_s).to eq output
  end
end

