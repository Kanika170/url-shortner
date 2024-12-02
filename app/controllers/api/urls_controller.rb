module Api
  class UrlsController < ApplicationController
    before_action :authenticate_request!

    # POST /api/urls
    def create
      url = Url.new(original_url: params[:original_url])

      if url.save
        render json: { short_url: url_shortener_url(url.short_url) }, status: :created
      else
        render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/urls/:short_url
    def show
      @url = Url.find_by(short_url: params[:short_url])

      if @url
        render json: {
          original_url: @url.original_url,
          short_url: url_shortener_url(@url.short_url)
        }, status: :ok
      else
        render json: { error: 'URL not found' }, status: :not_found
      end
    end

    private

    def authenticate_request!
      authenticate_or_request_with_http_token do |token, _options|
        ActiveSupport::SecurityUtils.secure_compare(token, ENV['API_TOKEN'])
      end
    end
  end
end
