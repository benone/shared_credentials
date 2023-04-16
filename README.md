# SharedCredentials

With this gem you can store credentials for different environments using https://edgeguides.rubyonrails.org/security.html#custom-credentials in one file.


## For example:
```
default: &default
  secret_key_base: ...
  openai:
    key: ...

development:
  <<: *default

production:
  <<: *default

test:
  <<: *default
```

## Installation

## Usage

```
secret = SharedCredentials.env.openai
```
