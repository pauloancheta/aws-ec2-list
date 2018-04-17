class AwsEc2List::Instance

  include Virtus.model

  attribute :instance_id, String
  attribute :state, String
  attribute :private_dns_name, String
  attribute :public_dns_name, String
  attribute :instance_type, String
  attribute :image_id, String
  attribute :launch_time, String
  attribute :tags, Array


  def name
    tags.find{ |t| t.key == "Name" }.value rescue nil
  end

  def stack_name
    tags.find{ |t| t.key == "aws:cloudformation:stack-name" }.value rescue nil
  end

  def project
    tags.find{ |t| t.key == "project" }.value rescue nil
  end

  def app_version
    tags.find{ |t| t.key == "app_version" }.value rescue nil
  end
end
