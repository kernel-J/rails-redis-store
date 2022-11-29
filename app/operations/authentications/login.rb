class Authentications::Login < Transactions::MonadBase

  def call(params:)    
    user = User.find(username: params[:username].downcase)

    if user.count == 0
      return Failure(error: ['either name or password is incorrect'])
    end

    pw = BCrypt::Password.new(user.first.password)
    unless pw == params[:password] + ENV['PEPPER']
      return Failure(error: ['either name or password is incorrect'])
    end
    
    Success()
  end
end