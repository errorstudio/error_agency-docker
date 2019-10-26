# ErrorAgency::Docker

A Rails generator to add docker configurations to your application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'error_agency-docker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install error_agency-docker

## Usage

### Development Environment
Run `rails g error_agency:docker:development_environment` to set up docker configs for development.

The following optional switches add more containers or change behaviour:

`--elasticsearch` - add an elasticsearch container
`--elasticsearch-version` - defaults to 6.2.4
`--headless-chrome` - add a headless chrome container for selenium tests
`--mysql-version` - defaults to 5.6
`--ruby-version` - defaults to 6.2.5 

Requires Rails 5 or 6.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/errorstudio/error_agency-docker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
