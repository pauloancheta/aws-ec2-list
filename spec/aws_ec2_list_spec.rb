require "spec_helper"
require_relative 'aws_ec2_list/ec2_double'

describe AwsEc2List do
  it "has a version number" do
    expect(AwsEc2List::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(AwsEc2List.call(ec2: AwsEc2List::Ec2Double, region: 'us-west-1')).to eq true
  end
end
