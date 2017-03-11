require_relative 'instance'

class AwsEc2List::DescribeInstances
  attr_reader :ec2, :stdout, :columns

  def initialize(ec2: Aws::EC2::Client,
                 stdout: $stdout,
                 region: 'us-east-1',
                 columns: "project, stack_name, public_dns_name, launch_time, app_version, state")

    @ec2 = ec2.new(region: region)
    @stdout = stdout
    @columns = columns
  end

  def call
    data_header = columns.split(", ")

    data = instances.map do |d|
      data_header.map do |header|
        d.send(header)
      end
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
