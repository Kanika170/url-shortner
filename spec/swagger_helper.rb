# spec/swagger_helper.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify the root folder where Swagger files are generated
  # Since the file is in 'public/api-docs', it will be accessible at '/api-docs'
  config.openapi_root = Rails.root.join('public', 'api-docs').to_s

  # Define the Swagger documents and provide global metadata
  config.openapi_specs = {
    'swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {}, # This will be populated by your specs
      servers: [
        {
          url: 'http://localhost:3000/api' # The base URL of your API
        }
      ]
    }
  }

  # Specify the format of the output Swagger file
  config.openapi_format = :yaml
end
