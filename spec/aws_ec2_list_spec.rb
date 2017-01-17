require "spec_helper"
require_relative 'aws_ec2_list/ec2_double'

describe AwsEc2List do
  let(:stdout) { MyIO.new }
  let(:ec2) { AwsEc2List::Ec2Double }
  let(:region) { 'us-west-1' }

  before { AwsEc2List.call(ec2: ec2, region: region, stdout: stdout) }

  it "has a version number" do
    expect(AwsEc2List::VERSION).not_to be nil
  end

  it "prints out the ec2 instances available" do
    expect(stdout.to_s).to eq %(PROJECT | STACK NAME        | PUBLIC DNS NAME | LAUNCH TIME | APP VERSION | STATE
webapp  | lp-webapp-prod-01 | public_dns_name | launch_time | 123h12kj    | state)
  end
end

class MyIO
  def initialize
    @content = ""
  end

  def puts(msg)
    @content = msg.join("\n")
  end

  def to_s
    @content
  end
end
