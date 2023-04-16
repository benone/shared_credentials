# frozen_string_literal: true

require_relative "shared_credentials/version"

module SharedCredentials
  class Error < StandardError; end

  # Your code goes here...
  def self.deep_transform(hash)
    return hash unless hash.is_a?(Hash)

    h = ActiveSupport::InheritableOptions.new
    hash.each do |k, v|
      h[k] = deep_transform(v)
    end
    h
  end

  def self.env
    hash = Rails.application.credentials.fetch(Rails.env.to_sym)
    ActiveSupport::InheritableOptions.new(deep_transform(hash))
  end
end
