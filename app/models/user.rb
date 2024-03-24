class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :prefered_city, inclusion: { in: City::NAMES }

  before_validation :sanitize_prefered_city
  before_save :downcase_email

  private

  def sanitize_name
    self.name = name.strip.downcase
  end

  def downcase_email
    self.email = email.downcase
  end
end
