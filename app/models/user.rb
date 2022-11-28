class User < Ohm::Model
  attribute :username
  attribute :password
  attribute :confirmation_at
  
  unique :username
  
  index :username

  def persisted?
    true
  end
end