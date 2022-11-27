require "rails_helper"

describe "Authentications::Validator" do
  describe "#call" do
    it 'fails when password length is less than Authentications::Validator.LENGTH' do
      result = Authentications::Validator.call(password: "pass")
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'fails when password does not contain a number' do
      result = Authentications::Validator.call(password: "Strongp@ssword")
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'fails when password does not contain a capital letter' do
      result = Authentications::Validator.call(password: "strongp@ssword1")
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'fails when password does not contain a special charaters' do
      result = Authentications::Validator.call(password: "Strongpassword1")
      
      expect(result.success?).to(eq(false))
      expect(result.failure[:errors]).to(be_present)
    end

    it 'returns true' do
      result = Authentications::Validator.call(password: "Strongp@ssword1")
      
      expect(result.success?).to(eq(true))
    end
  end
end
