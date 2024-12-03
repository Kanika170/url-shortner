# config/initializers/rswag_api.rb

Rswag::Api.configure do |config|
  # Specify the root folder where Swagger files are generated
  config.openapi_root = Rails.root.join('public', 'api-docs').to_s
end
