require "spec_helper"

describe AwsEc2List::ParseOption do

  subject do
    AwsEc2List::ParseOption.new(args: args).call
  end

  context "given option string is nil" do
    let(:args) { [] }
    it "returns an empty hash" do
      expect(subject).to eq({})
    end
  end

  context "given passed in one option" do
    let(:args) { ["--option=value"] }
    it "returns a hash" do
      expect(subject).to eq({option: "value"})
    end
  end

  context "given passed in two options" do
    let(:args) { ["--option=value --option2=value1 value2"] }
    it "returns a hash" do
      expect(subject).to eq({option: "value", option2: "value1 value2"})
    end
  end
end
