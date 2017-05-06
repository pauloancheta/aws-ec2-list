require "spec_helper"

describe AwsEc2List::DescribeInstances do
  let(:stdout) { AwsEc2List::IODouble.new }
  let(:ec2) { AwsEc2List::Ec2Double }
  let(:region) { 'us-west-1' }

  def output
    """project | stack_name        | public_dns_name | launch_time | app_version | state
webapp  | lp-webapp-prod-01 | public_dns_name | launch_time | 123h12kj    | state"""
  end

  it "returns the instances" do
    AwsEc2List::DescribeInstances.new(ec2: ec2, region: region, stdout: stdout).call
    expect(stdout.to_s).to eq output
  end
end
