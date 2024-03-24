class ApplicationService
  include ActiveModel::Validations

  def self.call(*args, &block)
    new(*args, &block).tap(&:call)
  end

  def call
    raise NotImplementedError
  end

  def fail!(message)
    errors.add(:base, message)
  end

  def error?
    errors.any?
  end

  def error_messages
    errors.full_messages.join(", ")
  end

  def success?
    errors.none?
  end
end
