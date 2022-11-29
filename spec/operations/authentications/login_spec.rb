require 'rails_helper'

describe 'Authentications::Login' do
  let(:params) { {username: "snoopy", password: "SecretP@ssword1"} }
  let(:pepper) { 'PepperString' }
  let(:pepped_password) { params[:password] + pepper}

  describe "#call" do
    it 'fails when user is not found' do
      allow(User).to receive(:find).with(username: params[:username]).and_return([])

      result = Authentications::Login.call(params: params)

      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'fails when password does not match' do
      ENV['PEPPER'] = "PepperString"
      user = double()
      user.stub(:password).and_return(pepped_password)

      allow(User).to receive(:find)
                .with(username: params[:username])
                .and_return([user])
                
      allow(BCrypt::Password).to receive(:new).with(pepped_password).and_return('toto')

      result = Authentications::Login.call(params: params)

      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'success' do
      ENV['PEPPER'] = "PepperString"
      user = double()
      user.stub(:password).and_return(pepped_password)

      allow(User).to receive(:find)
                .with(username: params[:username])
                .and_return([user])
                
      allow(BCrypt::Password).to receive(:new).with(pepped_password).and_return(pepped_password)


      result = Authentications::Login.call(params: params)

      expect(result.success?).to(eq(true))
    end
  end
end