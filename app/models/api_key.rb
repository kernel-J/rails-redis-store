class ApiKey < Ohm::Model
  attribute :bearer_id
  attribute :bearer_type
  attribute :token
  attribute :timestamp

  index :bearer_id
  index :token

  unique :token

  reference :user, :User

  def to_hash
    super.merge(
      :bearer_id => bearer_id,
      :bearer_type => bearer_type,
      :token => token,
      :timestamp => timestamp
    )
  end
end