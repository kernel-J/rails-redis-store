class Authentications::Validator < Transactions::MonadBase
  LENGTH = 12

  def call(password:)
    yield valid_length?(password)
    yield check_password_requirments(password)

    Success(true)
  end

  private

  def valid_length?(password)
    if password.length < LENGTH
      Failure(errors: ["must be at least 12 characters long"])
    else
      Success()
    end
  end

  def check_password_requirments(password)
    rules = {
      "must contain at least one lowercase letter"  => /[a-z]+/,
      "must contain at least one uppercase letter"  => /[A-Z]+/,
      "must contain at least one digit"             => /\d+/,
      "must contain at least one special character" => /[^A-Za-z0-9]+/
    }

    errors = []

    rules.each do |message, regex|
      errors << message unless password.match( regex )
    end

    if errors.empty?
      Success()
    else
      Failure(errors: errors)
    end
  end
end