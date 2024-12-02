class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url, notice: 'Shortened URL created successfully!'
    else
      render :new
    end
  end

  def show
    @url = Url.find_by(short_url: params[:id])
    redirect_to @url.original_url if @url
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
