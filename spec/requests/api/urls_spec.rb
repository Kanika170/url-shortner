require 'rails_helper'

RSpec.describe 'API::Urls', type: :request do
  API_TOKEN = 'test'

  describe 'POST /api/urls' do
    it 'shortens a URL successfully' do
      post '/api/urls', params: { url: { original_url: 'https://example.com' } }, headers: { 'Authorization' => "Bearer #{API_TOKEN}" }

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('URL shortened successfully')
      expect(json_response['short_url']).to include('/api/urls/')
    end

    it 'returns an error for invalid URL' do
      post '/api/urls', params: { url: { original_url: 'invalid_url' } }, headers: { 'Authorization' => "Bearer #{API_TOKEN}" }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('Original url is invalid')
    end
  end

  describe 'GET /api/urls/:short_url' do
    before do
      @url = Url.create(original_url: 'https://www.google.com/')
    end

    it 'retrieves the original URL' do
      get "/api/urls/#{@url.short_url}", headers: { 'Authorization' => "Bearer #{API_TOKEN}" } 

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['original_url']).to eq('https://www.google.com/') 
    end

    it 'returns a not found error for nonexistent short URL' do
      get '/api/urls/nonexistent', headers: { 'Authorization' => "Bearer #{API_TOKEN}" } 

      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq(['URL not found'])
    end
  end
end