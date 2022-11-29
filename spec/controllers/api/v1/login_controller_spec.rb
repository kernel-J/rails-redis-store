require 'rails_helper'

# TODO
describe 'Login', type: :request do
  describe 'POST /index' do
    context 'with valid parameters' do
      xit 'success' do
      end
  
      xit 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      xit 'fails' do
      end
  
      xit 'returns status code 200' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end