# SharedCredentials

A Ruby gem that extends Rails credentials to support multiple environments using a single credentials file with YAML inheritance.

Instead of managing separate credentials files for each environment, this gem allows you to use Rails' encrypted credentials system with environment-specific configurations in one file.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem "shared_credentials"
```

And then execute:

```bash
bundle install
```

## Setup

1. Edit your Rails credentials file:
   ```bash
   rails credentials:edit
   ```

2. Structure your credentials using YAML inheritance:
   ```yaml
   default: &default
     secret_key_base: your_secret_key_base
     openai:
       key: sk-your-openai-key
       organization: org-your-org
     database:
       password: your_db_password

   development:
     <<: *default
     # Override any development-specific values here
     database:
       password: dev_password

   production:
     <<: *default
     # Override any production-specific values here
     openai:
       key: sk-your-production-openai-key

   test:
     <<: *default
     # Override any test-specific values here
     database:
       password: test_password
   ```

## Usage

Access your environment-specific credentials using dot notation:

```ruby
# Get OpenAI credentials for current environment
openai_key = SharedCredentials.env.openai.key
openai_org = SharedCredentials.env.openai.organization

# Get database password for current environment  
db_password = SharedCredentials.env.database.password

# Access nested configurations
api_config = SharedCredentials.env.external_api
```

The gem automatically uses the correct environment section based on `Rails.env`.

## How it Works

- `SharedCredentials.env` reads from `Rails.application.credentials` using the current Rails environment
- Nested hashes are converted to `ActiveSupport::InheritableOptions` for dot notation access
- YAML inheritance (`<<: *default`) allows you to define common values once and override them per environment

## Development

After checking out the repo, run `bin/setup` to install dependencies. Run `rake` to run RuboCop for code quality checks.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/shared_credentials.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
