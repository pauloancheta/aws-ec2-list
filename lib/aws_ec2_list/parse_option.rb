require 'byebug'

class AwsEc2List::ParseOption
  include Virtus.model

  attribute :args, Array

  def call
    return {} if args.nil? || args.flatten.empty?
    option_string_to_hash
  end

  private
  def option_string_to_hash
    hash = Hash[*parse_array]

    hash.keys.each do |key|
      hash[key.to_sym] = hash.delete(key).strip
    end

    hash
  end

  def parse_array
    multi_option.map{ |opt| opt.split("=") }.flatten
  end

  def multi_option
    option_string.split("--").reject { |o| o.empty? }
  end

  def option_string
    args.flatten.join(" ")
  end
end
