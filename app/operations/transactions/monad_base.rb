class Transactions::MonadBase

  include Dry::Monads[:result, :do]
  include Dry::Monads::Do.for(:call)

  def self.call(*args, &block)
    new.call(*args, &block)
  end

end