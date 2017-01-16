require 'virtus'

class AwsEc2List::Ec2Double
  include Virtus::Model

  attribute :region, String

  def describe_instances
    return self
  end

  def reservations
    [
      AwsEc2List::InstancesDouble.new,
      AwsEc2List::InstancesDouble.new,
      AwsEc2List::InstancesDouble.new,
      AwsEc2List::InstancesDouble.new,
    ]
  end
end

class AwsEc2List::InstancesDouble
  def instances
    return self
  end

  def instance_id
    "instance_id"
  end

  def state
    OpenStruct.new(name: "state")
  end

  def private_dns_name
    "private_dns_name"
  end

  def public_dns_name
    "public_dns_name"
  end

  def instance_type
    "instance_type"
  end

  def launch_time
    "launch_time"
  end

  def tags
    [
      OpenStruct.new(key: "Name", value: "lp-webapp-prod"),
      OpenStruct.new(key: "aws:cloudformation:stack-name", value: "lp-webapp-prod-01"),
      OpenStruct.new(key: "project", value: "webapp"),
      OpenStruct.new(key: "app_version", value: "123h12kj")
    ]
  end
end
