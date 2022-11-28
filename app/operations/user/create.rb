class User::Create < Transactions::MonadBase
  def call(params:)

    yield Authentications::Validator.call(password: params[:password])

    hashed = BCrypt::Password.create(params[:password] + ENV['PEPPER'])

    user = User.create(:name => params[:name].downcase, :password => hashed)

    user.save
  end
end