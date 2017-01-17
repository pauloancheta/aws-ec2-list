require_relative 'instance'

class AwsEc2List::Runner
  attr_reader :ec2, :stdout

  def initialize(ec2: Aws::EC2::Client, region: 'us-east-1', stdout: $stdout)
    @ec2 = ec2.new(region: region)
    @stdout = stdout
  end

  def call
    data_header = ["PROJECT", "STACK NAME", "PUBLIC DNS NAME", "LAUNCH TIME", "APP VERSION", "STATE"]
    data = instances.map do |d|
      [d.project, d.stack_name, d.public_dns_name, d.launch_time, d.app_version, d.state]
    end
    data = data.insert(0, data_header)
    stdout.puts Tabularize.it(data, :align => :left).map { |row| row.join ' | ' }
  end

  private

  def instances

    #  Aws::EC2::Types::Instance
    #  instance_id="i-0e5846a2b3988300d",
    #  state=#<struct Aws::EC2::Types::InstanceState code=16, name="running">,
    #  private_dns_name="ip-172-16-92-73.ec2.internal",
    #  public_dns_name="ec2-54-157-47-22.compute-1.amazonaws.com",
    #  instance_type="m4.xlarge",
    #  launch_time=2017-01-12 19:46:29 UTC,
    #  subnet_id="subnet-844ef9df",
    #  vpc_id="vpc-2d583b48",
    #  private_ip_address="172.16.92.73",
    #  public_ip_address="54.157.47.22",
    #  architecture="x86_64",
    #  client_token="40459b52-177d-4e54-a3ed-e07e9d434ecc_subnet-844ef9df_5",
    #  tags=[
    #    #<struct Aws::EC2::Types::Tag key="Name", value="lp-webapp-product-0e5846a2b3988300d">,
    #    #<struct Aws::EC2::Types::Tag key="aws:cloudformation:logical-id", value="WebASG">,
    #    #<struct Aws::EC2::Types::Tag key="owner", value="a-team">,
    #    #<struct Aws::EC2::Types::Tag key="environment", value="production">,
    #    #<struct Aws::EC2::Types::Tag key="aws:autoscaling:groupName", value="lp-webapp-production-31-WebASG-RYQPV710NC8B">,
    #    #<struct Aws::EC2::Types::Tag key="aws:cloudformation:stack-name", value="lp-webapp-production-31">,
    #    #<struct Aws::EC2::Types::Tag key="app_version", value="9da8527">,
    #    #<struct Aws::EC2::Types::Tag key="aws:cloudformation:stack-id", value="arn:aws:cloudformation:us-east-1:002682819933:stack/lp-webapp-production-31/09547990-d8ff-11e6-aedf-50fae9882035">,
    #    #<struct Aws::EC2::Types::Tag key="datadog", value="true">,
    #    #<struct Aws::EC2::Types::Tag key="project", value="lp-webapp">
    #  ],
    #  security_groups=[
    #    #<struct Aws::EC2::Types::GroupIdentifier group_name="vpc-us-east-classic-link-ClassicLinkSecurityGroup-1H5UKPIA5IANJ", group_id="sg-87c20ce3">,
    #    #<struct Aws::EC2::Types::GroupIdentifier group_name="shared-security-groups-mainvpc-SshSecurityGroup-15DV69GVO6M5F", group_id="sg-c5ba0db8">
    #  ]
    reservations.map(&:instances).flatten.map do |instance|
      AwsEc2List::Instance.new(
        instance_id: instance.instance_id,
        state: instance.state.name,
        private_dns_name: instance.private_dns_name,
        public_dns_name: instance.public_dns_name,
        instance_type: instance.instance_type,
        launch_time: instance.launch_time,
        tags: instance.tags
      )
    end.sort{ |x, y| y.launch_time <=> x.launch_time }
  end

  def reservations
    describe_instances.reservations
  end

  def describe_instances
    ec2.describe_instances
  end
end
