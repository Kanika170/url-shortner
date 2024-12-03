module Api
  class UrlsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_request!, only: [:create]

    # POST /api/urls
    def create
      url = Url.new(url_params)

      if url.save
        render_success("URL shortened successfully", generate_short_url(url.short_url))
      else
        render_error(url.errors.full_messages, :unprocessable_entity)
      end
    end

    # GET /api/urls/:short_url
    def show
      url = Url.find_by(short_url: params[:short_url])

      if url
        render json: { 
          original_url: url.original_url, 
          short_url: generate_short_url(url.short_url) 
        }, status: :ok
      else
        render_error('URL not found', :not_found)
      end
    end

    private

    def url_params
      params.require(:url).permit(:original_url)
    end

    def authenticate_request!
      token = request.headers['Authorization']&.split(' ')&.last
      unless token && ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('TOKEN', ''))
        render_error('Unauthorized access', :unauthorized)
      end
    end

    def generate_short_url(short_url_segment)
      "#{request.protocol}#{request.host_with_port}/api/urls/#{short_url_segment}"
    end

    def render_success(message, short_url)
      render json: { message: message, short_url: short_url }, status: :created
    end

    def render_error(message, status)
      render json: { error: Array(message) }, status: status
    end
  end
end
