require 'rails_helper'

describe 'User', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) do
        {
          format: :json,
          user: {
            username: 'Snoopy',
            password: 'SecretP@ssword1'
          },
        }
      end

      before do
        result = double()
        result.stub(:success?).and_return(true)
        result.stub_chain(:success, :to_hash)
              .and_return({:username => 'Snoopy', :password => 'SecretP@ssword1', :confirmation_at => nil})
        allow(User::Create).to receive(:call).and_return(result)

        post '/api/v1/user', params: params
      end

      it 'returns a created status' do
        expect(User::Create).to have_received(:call)
  
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        result = double()
        result.stub(:success?).and_return(false)
        result.stub(:failure).and_return({errors: ['error']})
        allow(User::Create).to receive(:call).and_return(result)

        post '/api/v1/user', params:
                                { user: {
                                  username: '',
                                  password: ''
                                } }
      end

      it 'returns a bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end