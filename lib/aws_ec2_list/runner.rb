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
