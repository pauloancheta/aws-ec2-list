# Aws::Ec2::List

Get the information from your ec2 instances

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aws-ec2-list'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws-ec2-list

## Usage

AwsEc2List defaults to us-east-1

```bash
$> aws-ec2-list
```

Specify a specific region with `--region` option

```bash
$> aws-ec2-list --region=us-west-2
```

Specify the columns that you would like to show.
```bash
$> aws-ec2-list --columns="name, project, state"
```

Just a small note, not all tags work. Currently you can only query:
  - instance_id
  - state
  - private_dns_name
  - public_dns_name
  - instance_type
  - launch_time
  - name
  - stack_name
  - project
  - app_version


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aws-ec2-list.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

