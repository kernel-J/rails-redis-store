require "rails_helper"

describe "User::Create" do
  describe "#validate_username" do
    it 'fails when username is less than 3 characters' do
      result = User::Create.new.validate_username('')
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'fails when username is greater than 25 characters' do
      result = User::Create.new.validate_username('This is a really long user name')
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'success' do
      result = User::Create.new.validate_username('user')
      
      expect(result.success?).to(eq(true))
    end
  end

  describe "#create_user" do
    let(:params) { {username: 'user'} }
    let(:hashed_password) { 'hashed_password' }

    it 'fails when data not saved to db' do
      user = double()
      user.stub(:save).and_return(false)

      allow(User).to receive(:create).with({username: params[:username], password: hashed_password}).and_return(user)

      result = User::Create.new.create_user(params, hashed_password)

      expect(result.failure[:errors]).to(be_present)
    end

    it 'success' do
      user = double()
      user.stub(:save).and_return(true)

      allow(User).to receive(:create).with({username: params[:username], password: hashed_password}).and_return(user)

      result = User::Create.new.create_user(params, hashed_password)

      expect(result.success).to eq(user)
    end
  end

  # TODO
  describe "#create_api_key" do
    xit 'fails to create api_key' do
    end

    xit 'success' do
    end
  end
end
