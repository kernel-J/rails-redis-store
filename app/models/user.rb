class User < Ohm::Model
  attribute :name
  attribute :password
  attribute :confirmation_at

  ## TO DO: add validation to name
  # def validate
  #   assert_present :name
  #   assert_format :name, /^[a-z]+$/
  # end

  def persisted?
    true
  end
end