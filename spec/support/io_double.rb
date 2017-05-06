class AwsEc2List::IODouble
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
