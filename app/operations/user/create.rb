class User::Create < Transactions::MonadBase
  def call(params:)
    yield Authentications::Validator.call(password: params[:password])

    hashed = BCrypt::Password.create(params[:password] + ENV['PEPPER'])

    user = yield create_user(params, hashed)

    api_key = yield create_api_key(user)

    Success(api_key)

  end

  def create_user(params, hashed)
    begin
      user = User.create(:username => params[:username].downcase, :password => hashed)

      if user.save
        Success(user)
      else
        Failure(errors: ['failed to save user'])
      end
    rescue => error
      Failure(errors: ['username already exists'])
    end
  end

  def create_api_key(user)
    begin
      api_key = ApiKey.create(
        :bearer_id => user.id,
        :bearer_type => user.class.name,
        :token => SecureRandom.hex,
        :timestamp => DateTime.now
      )

      if api_key.save
        Success(api_key)
      else
        Failure(errors: ["failed to create api_key for user_id: #{user.id}"])
      end
    rescue => error
      Failure(errors: ['token already exsits'])
    end
  end
end