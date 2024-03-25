# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  prefered_city   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :prefered_city, inclusion: { in: City::NAMES, allow_nil: true }

  before_validation :sanitize_prefered_city, if: :prefered_city
  before_save :downcase_email

  private

  def sanitize_prefered_city
    self.prefered_city = prefered_city.strip.downcase
  end

  def downcase_email
    self.email = email.downcase
  end
end
