class User < Ohm::Model
  attribute :username
  attribute :password
  attribute :confirmation_at
  
  unique :username
  
  index :username

  collection :api_keys, :ApiKey

  def to_hash
    super.merge(:username => username, :password => password, :confirmation_at => confirmation_at)
  end

  def persisted?
    true
  end
end