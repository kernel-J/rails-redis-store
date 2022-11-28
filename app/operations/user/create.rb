class User::Create < Transactions::MonadBase
  def call(params:)
    Ohm.redis = Redic.new(ENV["REDIS_URL"])

    yield Authentications::Validator.call(password: params[:password])

    hashed = BCrypt::Password.create(params[:password] + ENV['PEPPER'])

    begin
      user = User.create(:username => params[:username].downcase, :password => hashed)

      if user.save
        Success()
      else
        Failure(error: ['failed to save user'])
      end
    rescue => error
      Failure(error: ['username already exists'])
    end
  end
end