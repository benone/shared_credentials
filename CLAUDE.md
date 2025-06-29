# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Type
Ruby gem that extends Rails credentials to support multiple environments in a single file using YAML inheritance.

## Essential Commands

```bash
# Development setup
./bin/setup

# Code quality (default rake task)
rake

# Interactive testing
./bin/console

# Local testing
rake install:local
```

## Architecture

**Core API:**
- `SharedCredentials.env` - Access environment-specific credentials
- `SharedCredentials.deep_transform(hash)` - Recursive hash to `InheritableOptions` conversion

**Dependencies:** Requires Rails environment (`Rails.application.credentials`, `Rails.env`, `ActiveSupport`)

**Credentials Structure:**
```yaml
default: &default
  openai:
    key: sk-xxx

development:
  <<: *default

production:
  <<: *default
```

**Usage:** `SharedCredentials.env.openai.key`

## Code Standards
- Ruby >= 2.6.0
- Double quotes (RuboCop enforced)
- 120 char line limit
- Frozen string literals

## Testing
No test suite exists. Test integration by:
1. `rake install:local`
2. Add to Rails app Gemfile
3. Structure credentials with environment sections
4. Verify dot-notation access works