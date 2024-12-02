module Api
  class UrlsController < ApplicationController
    def create
      url = Url.new(original_url: params[:original_url])
      if url.save
        render json: { short_url: url.short_url }, status: :created
      else
        render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
